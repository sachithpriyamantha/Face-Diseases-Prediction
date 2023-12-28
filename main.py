import tensorflow as tf
import numpy as np
from tensorflow.keras.preprocessing.image import img_to_array, load_img
from tensorflow.keras.models import load_model
import os
import matplotlib.pyplot as plt
import cv2

# Constants
IMAGE_SIZE = 224
MODEL_PATH = 'my_model.h5' 
TEST_IMAGE_DIR = 'D:\\Final Year Project\\images\\testing' 
CLASSES = ['Acne', 'Actinic Keratosis', 'Basal Cell Carcinoma', 'Eczema', 'Rosacea'] 

# Load the trained model
model = load_model(MODEL_PATH)

# add new
model.load_weights("facedetector.h5")
haar_file=cv2.data.haarcascades + 'haarcascade_frontalface_default.xml'
face_cascade=cv2.CascadeClassifier(haar_file)
def extract_features(image):
    feature = np.array(image)
    feature = feature.reshape(1,48,48,1)
    return feature/255.0


# preprocess the image
#def preprocess_image(image_path):
    """Load and preprocess an image."""
    img = load_img(image_path, target_size=(IMAGE_SIZE, IMAGE_SIZE))
    img = img_to_array(img)
    img = np.expand_dims(img, axis=0)
    img /= 255.0
    return img


#predict 
#def predict_condition(image_path):
    """Predict the skin condition of a given image."""
    img = preprocess_image(image_path)
    prediction = model.predict(img)
    predicted_class = CLASSES[np.argmax(prediction)]
    return predicted_class


# Testing the model with test images
#for condition_dir in os.listdir(TEST_IMAGE_DIR):
    condition_path = os.path.join(TEST_IMAGE_DIR, condition_dir)
    if os.path.isdir(condition_path):
        for image_file in os.listdir(condition_path):
            image_path = os.path.join(condition_path, image_file)
            predicted_class = predict_condition(image_path)
            print(f"Image: {image_file} - Predicted Condition: {predicted_class}")

            # Display the image with the predicted label
            img = load_img(image_path)
            plt.imshow(img)
            plt.title(f"Predicted Condition: {predicted_class}")
            plt.show()#


           


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

        # Display the resulting frame
        cv2.imshow('Webcam Feed', frame)

        # Break the loop when a key is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # Release the capture and close any open windows
    cap.release()
    cv2.destroyAllWindows()


def preprocess_image(image):
    """ Preprocess the image for the model """
    img = img_to_array(image)
    img = np.expand_dims(img, axis=0)
    return img / 255.0
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
        processed_frame = cv2.resize(frame, (IMAGE_SIZE, IMAGE_SIZE))
        processed_frame = preprocess_image(processed_frame)

        # Predict the disease
        prediction = model.predict(processed_frame)
        disease = CLASSES[np.argmax(prediction)]

        # Display the resulting frame with prediction
        cv2.putText(frame, f'Detected: {disease}', (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv2.imshow('Webcam Feed - Disease Detection', frame)

        # Break the loop when a key is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    # Release the capture and close any open windows
    cap.release()
    cv2.destroyAllWindows()

# Run the function
open_webcam()

