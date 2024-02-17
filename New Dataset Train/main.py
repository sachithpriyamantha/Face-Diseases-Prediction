import os

import cv2
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import img_to_array, load_img

# Load your trained model
model = load_model('D:/FaceDiseases/my_model.h5')
CLASSES = ['Acne', 'Atopic Dermatitis', 'Eczema', 'Seborrheic Keratoses', 'Tinea Ringworm']
IMAGE_SIZE = 224



def preprocess_frame(frame):
    """
    Preprocess the frame from the camera to the format expected by the model.
    This includes resizing to the expected dimensions and normalization if required.
    """
    # Resize the frame to match the model's expected input shape
    frame_resized = cv2.resize(frame, (256, 182))  # Adjust the dimensions to match the model's expected input
    frame_normalized = frame_resized / 255.0  # Normalize pixel values if required by your model
    return np.expand_dims(frame_normalized, axis=0)  # Add batch dimension for prediction


# Initialize camera
def open_webcam():
    # Create a VideoCapture object to access the webcam
    cap = cv2.VideoCapture(0)

    if not cap.isOpened():
        print("Error: Could not open webcam.")
        return

    while True:
        # Capture frame-by-frame
        ret, frame = cap.read()

        if not ret:
            print("Error: Could not read frame.")
            break

        # Preprocess the frame for disease detection
        processed_frame = preprocess_frame(frame)

        # Predict the disease
        prediction = model.predict(processed_frame)
        
        #disease_present = prediction[0][0] > 0.5
        disease = CLASSES[np.argmax(prediction)]
        
        # Display the resulting frame with prediction
       
        cv2.putText(frame, f'Detected: {disease}', (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2, cv2.LINE_AA)
        #cv2.imshow('Webcam Feed - Disease Detection', frame)

        
        cv2.imshow('Frame', frame)

          


        # Break the loop when a key is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
          break

# When everything is done, release the capture
    cap.release()
cv2.destroyAllWindows()

# Run the function
open_webcam()
cv2.destroyAllWindows()

# Run the function
open_webcam()