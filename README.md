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

## Basic examination
* mean(average) of price values is 152$, min is 0 and max is 10000. while 75% mark of price distribution is 175 there's 10000 priced listing which hint some error in data entry or can be a natural variance. We'll explore this later.
* there are listings that have minimum nights 1250 which can be a error in data or natural variance.
* number of reviews column data seems ok.
* reviews per month column has missing values.
* some hosts have multiple properties and the host that owns most properties owns 327 properties.
*  availability_365 means the number of days the facility is available to be booked in the future 365 days. Some listings have 0 for this and max is 365

## What we can learn about location?
Interesting topics for research
* What boroghs or neighbourhoods have most expensive listings?
* What boroghs or neighbourhoods are most busy?
* What host is the most busy and his property distrubution around the NYC.
* What property is the most busy and where it is located.
* What boroghs are the least busy and posible reasons.
* What type of listing are the most and least favorite?

## Price distribution
Key points
* Listing located in Manhattan are pricier than others. (above 150$)
* Some pricier(than others) listings are scattered around Queens as well.
* Host name that has most listings have listings in Brooklyn, Manhattan and few around other boroghs as well.
* Most expensive and favorite room type is Entire home/apt and least is shared room.
* there are about 1763 listings above 400\$ in price in dataset. Entire home/apt - 1535, Private room - 216, Shared room - 12
* There are 3 listings priced at 10000\$ they are in Astoria, Greenpoint and Upper West Side areas. 2 of them are entire home/apt 1 of them is private room. 2 of them have reviews.

After removing outliers in price column
* No listings for Shared rooms in Bronx. Staten Island have only 14.

## What key factors drive price the most
Key points
* Queens is the busiest according to reviews per month, Manhattan is the least busy. So Manhattan is pricier but less busy.
* Entire home/apt s in Bronx are the most busiest and shared rooms in Brooklyn are the least busy.
* busiest listing's host is Row NYC. Listing is in Manhattan, Theater Ditrict. It's a private room. price is close to average(of price distribution), have 156 reviews and average of 58.5 reviews per month. That's 702 reviews per year. Listing's is available for 299 days around the year.
* There are 42 listings with 0.01 average reviews per month. That is about 1 review per year. These are the least busiest. Brooklyn - 19, Manhattan - 19, Queens - 4.
* Among them 28 listings are Entire home/apt and 14 are private rooms.

## Predictive model
What can we predict? Do we have enough data to build a predictive model.

* Preprocessing
Preprocessing data to feed the model, split data for training, evaluating and testing
* Model
Try different regression models and see efficiency.

## Conclusion
Price is mostly affected by location and room types. But still that's not enough to build a linear regression model. Dataset is good for EDA purpose but not enough parameters for a predictive model.
