from flask import Flask, request,jsonify
import tensorflow as tf
import numpy as np
import json

keras = tf.keras
app = Flask(__name__)

# load model, encode dicts
# map the inputs and create input
# feed input to model and return preds

number_of_reviews_mean = 23
reviews_per_month_mean = 1.3
minimum_nights = 1
availability_365_mean = 112
cost_calculation_error = 40

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


def validatePredJsonData(data):
    errors = []
    print(errors)
    try:
        if data['neighbourhood_group'] == None:
            errors.append('neighbourhood_group is required')
        if data['neighbourhood'] == None:
            errors.append('neighbourhood is required')
        if data['room_type'] == None:
            errors.append('room_type is required')
        if data['nights'] == None:
            errors.append('nights is required')
        if isinstance(data['nights'],int)==False:
            errors.append('nights should be a integer')
        return errors

    except Exception as e:
        print('error in validation',e)
        return [e]
    
def calculateCost(pred_price,nights):
    cost_est = {
        "min": 0,
        "max":cost_calculation_error
    }

    cost_est['min'] = pred_price - cost_calculation_error/2
    if cost_est['min'] < 0:
        cost_est['min'] = 0
    
    cost_est['max'] = pred_price + cost_calculation_error/2

    return cost_est

@app.route('/pred',methods=['POST'])
def pred():
    try:
        body = request.json
        errors = validatePredJsonData(body)

        if len(errors)>0:
            raise Exception('validation_error',errors[0])
        
        # preprocess
        neighbourhood_group = body['neighbourhood_group']
        neighbourhood = body['neighbourhood']
        room_type = body['room_type']
        nights = body['nights']

        # neighbourhood_group	neighbourhood	room_type	minimum_nights	
        # number_of_reviews	availability_365

        if neighbourhood_group in neighbourhood_group_dict:
           neighbourhood_group = neighbourhood_group_dict[neighbourhood_group]
        else:
            neighbourhood_group = 0

        if neighbourhood in neighbourhood_dict:
           neighbourhood = neighbourhood_dict[neighbourhood]
        else:
            neighbourhood = 0

        if room_type in room_type_dict:
           room_type = room_type_dict[room_type]
        else:
            room_type = 0

        input = np.array([neighbourhood_group,neighbourhood,room_type,minimum_nights,number_of_reviews_mean,availability_365_mean])

        input = np.asarray(input).astype('float32')

        pred = model.predict([input])

        cost_est = calculateCost(pred[0][-1],nights)

        return jsonify({"pred":cost_est}),200
    except Exception as e:
        print(e)
        return jsonify({"error":str(e)}),500
    

if __name__ == "__main__":
    app.run(debug=True)