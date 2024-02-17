import tensorflow as tf
from tensorflow.keras.models import load_model

# Load the Keras model from the .h5 file
model = load_model('my_model.h5')

# Convert the model to TFLite format
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the TFLite model to a file
with open('my_model.tflite', 'wb') as f:
    f.write(tflite_model)