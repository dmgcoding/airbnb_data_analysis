# Airbnb NYC Data Analysis

Dataset I used describes the listing activity and metrics in NYC, NY for 2019.

Dataset link > https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data

## Problem Statement
Dataset contains close to 49000 records with 16 columns. These columns consist of list title, host id, host name, borough, neighourhood, total reviews, etc. Dataset doesn't contain critical data like do they offer wifi, free meals, how many squarefeet is the property, etc which will affect the pricing of the listing.

Analyze and see what we can learn from this data,
* What can we learn about different hosts and areas?
* What can we learn from predictions? (ex: locations, prices, reviews, etc)
* Which hosts are the busiest and why?
* Is there any noticeable difference of traffic among different areas and what could be the reason for it?

## Analyzing, Visualizing and Cleaning data
Here we analyze data, visualize, see correlations,decide what column do we need and what we don't need, remove unrelated columns, look for the null/na values or wrong data, treat those data, check outliers, treat the outliers and see if it needs more cleaning.

* Basic examination
* What we can learn about location?
* What can we learn about hosts?
* Price distribution
* What key factors drive price the most

## Predictive model
What can we predict? Do we have enough data to build a predictive model.

* Preprocessing
Preprocessing data to feed the model, split data for training, evaluating and testing
* Model
Try different regression models and see efficiency.

## Conclusion
Price is mostly affected by location and room types. But still that's not enough to build a linear regression model. Dataset is good for EDA purpose but not enough parameters for a predictive model.
