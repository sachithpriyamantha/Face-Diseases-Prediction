import tensorflow as tf
import numpy as np
from tensorflow.keras.preprocessing.image import img_to_array, load_img
from tensorflow.keras.models import load_model
import os
import matplotlib.pyplot as plt

# Constants
IMAGE_SIZE = 224
MODEL_PATH = 'my_model.h5' 
TEST_IMAGE_DIR = 'D:\\Final Year Project\\images\\testing' 
CLASSES = ['Acne', 'Actinic Keratosis', 'Basal Cell Carcinoma', 'Eczema', 'Rosacea'] 

# Load the trained model
model = load_model(MODEL_PATH)

# preprocess the image
def preprocess_image(image_path):
    """Load and preprocess an image."""
    img = load_img(image_path, target_size=(IMAGE_SIZE, IMAGE_SIZE))
    img = img_to_array(img)
    img = np.expand_dims(img, axis=0)
    img /= 255.0
    return img

#predict 
def predict_condition(image_path):
    """Predict the skin condition of a given image."""
    img = preprocess_image(image_path)
    prediction = model.predict(img)
    predicted_class = CLASSES[np.argmax(prediction)]
    return predicted_class


# Testing the model with test images
for condition_dir in os.listdir(TEST_IMAGE_DIR):
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
            plt.show()

