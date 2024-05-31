# ukio
Ukio test.

I try to create a booking:
```curl -X POST -d '{"booking":{"check_in": "2024-06-26", "check_out": "2024-07-26", "apartment_id": 2}}' -H '{"Content-Type": "application/json"}' http://localhost:4000/api/bookings```
```curl -X POST -H "accept: application/json" -H "Content-Type: application/json" -d '{"booking":{"check_in": "2024-06-26", "check_out": "2024-07-26", "apartment_id": 2}}' http://localhost:4000/api/bookings```
```curl -X POST -H "accept: application/json" -H "Content-Type: application/json" -d '{"booking":{"check_in": "2024-08-26", "check_out": "2024-09-26", "apartment_id": 2}}' http://localhost:4000/api/bookings```

First I created an endpoint to find the bookings of an apartment, using GET /apartments/:id/bookings.

Then, we can try to create a booking within any of the dates and it will throw a 401 (unauthorized) error.

–––––––––––––––––

Now run the SQL to create a new column PLANET
Then adapt the models: booking needs to make calculations when processing the cost and apartment needs a new column
Finally create the endpoint to create apartments
```curl -X POST -H "accept: application/json" -H "Content-Type: application/json" -d '{"apartment":{"name": "PHOBOS", "address": "Olympus 34", "zip_code": "09991", "monthly_price": 50000, "square_meters": 500, "planet": "MARS"}}' http://localhost:4000/api/apartments```
```curl -X POST -H "accept: application/json" -H "Content-Type: application/json" -d '{"apartment":{"name": "IO", "address": "Galileo 45", "zip_code": "09991", "monthly_price": 50000, "square_meters": 500, "planet": "JUPITER"}}' http://localhost:4000/api/apartments```
```curl -X POST -H "accept: application/json" -H "Content-Type: application/json" -d '{"apartment":{"name": "Europa", "address": "Galileo 44", "zip_code": "09991", "monthly_price": 50000, "square_meters": 500, "planet": "JUPITER"}}' http://localhost:4000/api/apartments```
```curl -X POST -H "accept: application/json" -H "Content-Type: application/json" -d '{"apartment":{"name": "Titan", "address": "Methane lake 1", "zip_code": "09991", "monthly_price": 50000, "square_meters": 500, "planet": "SATURN"}}' http://localhost:4000/api/apartments```
