# property_service

### Documentation

- Use gem activerecord-postgres-earthdistance to query properties within radius of a specific point
- Add earthdistance_index to speed up queries
- activerecord-postgres-earthdistance gem has good test coverage so its not necesarry to write own tests for the query method
- Create PropertySearchValidation for validating the query parameters and adding error messages using ActiveModel::Validations
- Added request specs to test api and unit test for PropertySearchValidation


### Background

At Homeday, we are working to improve the process of selling real estate by giving real estate agents the best tools to do their job.

One of the most important questions when dealing with real estate is the property price. Given a specific property, there isn't always a clear way to arrive at a price, but there are estimations, comparisons, historical data, etc. that can support an agent in giving a realistic price estimation.

We have accumulated an extensive database of real estate listings dating back several years ago and covering the whole Germany. That data is used both to provide estimations and values to compare.

### Your task

Your task will be to build a service that, given latitude and longitude of an object, its type and marketing type, returns a list of similar objects with their prices.

A little insight into terms: `property_type` is just either `apartment` or `single_family_house` and marketing type is either `rent` or `sell`.

Consider the following scenario:

- Alice, the real estate agent, is asked to estimate the sell price of an apartment that is located in Marienburger Straße 31 10405 Prenzlauer Berg, Berlin.
- Alice wants to figure out prices of similar apartments in Prenzlauer Berg
- Alice calls your service with the following params:
  - `lng` : `13.4236807`
  - `lat` : `52.5342963`
  - `property_type` : `apartment`
  - `marketing_type` : `sell`
- Alice receives a list of properies near the point she specified along with their prices.

Note that in the scenario above, Alice works with **coordinates** (`lat`, `lng`) and may not specify exact coordinates of an address.

What you have to do is to build a service that is:

- accessible with HTTP/HTTPS
- has a single endpoint that accepts latitude, longitude, property_type and marketing_type and returns a list of properties within a `5 kilometer` radius along with their addresses and price.

E.g. given the input of

```
lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell
```

the return value could look like

```
[
  {

    house_number: "31",
    street: "Marienburger Straße",
    city: "Berlin",
    zip_code: "10405
    state: "Berlin",
    lat: '13.4211476',
    lng: '52.534993',
    price: '350000'

  },
  {

    house_number: "16",
    street: "Winsstraße",
    city: "Berlin",
    zip_code: "10405"
    state: "Berlin",
    lat: '52.533533',
    lng: '13.425226',
    price: '320400'

  }
 # ... other properties
]
```

We also expect the service to handle errors and respond with meaningful status and error messages. Some error cases are:

- No data for given location
- Invalid input params

### Input data

the **/data** folder in this repo contains a PostgreSQL data dump containing a single table with a bunch of properties in Berlin. Use that data for your service.

### Requirements

The service should be written in Ruby.
The rest - framework, choice of libraries/gems/external services - is entirely up to you.

### What we expect as a result

- a github repo with your code
- tests, obviously
- a rationale behind the choices you've made

### Some hints

- Postgres has some functions to [calculate distance](https://www.postgresql.org/docs/9.6/static/earthdistance.html) that can be handy
- The service should have an obvious way to scale
- Response time is important
