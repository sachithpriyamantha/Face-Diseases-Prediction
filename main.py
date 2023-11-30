import cv2
from keras.models import load_model
import numpy as np
import matplotlib.pyplot as plt
from math import sqrt



# Load the pre-trained model
model = load_model('my_model.h5')

# Haar Cascade for face detection
haar_file = cv2.data.haarcascades + 'haarcascade_frontalface_default.xml'
face_cascade = cv2.CascadeClassifier(haar_file)

# Function to preprocess the image
def preprocess_image(image):
    processed_image = cv2.resize(image, (48, 48))
    processed_image = np.array(processed_image).reshape(1, 48, 48, 1)
    return processed_image / 255.0

# Labels for the diseases
labels = {0: 'Acne', 1: 'Actinic Keratosis', 2: 'Basal Cell Carcinoma', 3: 'Eczema', 4: 'Rosacea'}

# Starting the webcam
webcam = cv2.VideoCapture(0)

while True:
    ret, frame = webcam.read()
    if not ret:
        break

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)

    for (x, y, w, h) in faces:
        face_img = gray[y:y+h, x:x+w]
        preprocessed = preprocess_image(face_img)

        # Predicting the disease
        prediction = model.predict(preprocessed)
        disease_label = labels[np.argmax(prediction)]

        # Drawing a rectangle and putting text
        cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)
        cv2.putText(frame, disease_label, (x, y-10), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 2)

    cv2.imshow('Skin Disease Detection', frame)

    if cv2.waitKey(27) & 0xFF == ord('q'):
        break

webcam.release()
cv2.destroyAllWindows()
