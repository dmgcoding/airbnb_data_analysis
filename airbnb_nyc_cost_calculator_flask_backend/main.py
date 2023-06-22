from flask import Flask, request,jsonify
import tensorflow as tf
import numpy as np
import json

keras = tf.keras
app = Flask(__name__)

# load model, encode dicts
# map the inputs and create input
# feed input to model and return preds

try:
    model = keras.models.load_model('resources/airbnb_nyc_room_price_predict_model.h5')
    with open('resources\encoded_neighbourhood_groups_dict.json', 'r') as file:
        neighbourhood_group_dict = json.load(file)
        neighbourhood_group_dict = dict(neighbourhood_group_dict)

    with open('resources\encoded_neighbourhoods_dict.json', 'r') as file:
        neighbourhood_dict = json.load(file)
        neighbourhood_dict = dict(neighbourhood_dict)

    with open('resources\encoded_room_type_dict.json', 'r') as file:
        room_type_dict = json.load(file)
        room_type_dict = dict(room_type_dict)
except Exception as e:
    print("loading error")
    print(e)

@app.route('/pred',methods=['POST'])
def pred():
    try:
        val = room_type_dict[0]
        print(val)
        return jsonify({"d":"d"})
    except Exception as e:
        print(e)
        return jsonify({"error":'error'})
    

if __name__ == "__main__":
    app.run(debug=True)