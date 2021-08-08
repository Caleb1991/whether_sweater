# whether_sweater

Sweater weather.... I mean, Whether Sweater is an API that allows you the user to plan a road trip. In doing so, as long as it is a viable destination, you will be able to see the origin city, the destination city, travel time, and estimated weather in the destination city upon arrival.

<p>Through this project the following learning goals were achieved:
  *Consumption of multiple API's
  * Following RESTful conventions when creating API endpoints
  * Exposing aggregated data through serializers
</p>

# Setup

Clone this repo
<p>Run bundle install</p><p>Run bundle exec figaro install</p><p>Run rails db:create</p><p>You will need to get api_keys from the following websites and store them in your application.yml file [OpenWeather] (https://openweathermap.org/api/one-call-api), [GeoCoding] (https://developer.mapquest.com/documentation/geocoding-api/), [Unsplash] (https://unsplash.com/documentation)</p>

#Endpoints
<p> 'Http://localhost:3000' </p>
<p>GET '/api/v1/forecast?location={location}' </p>
<p> Location must be sent as 'Denver,CO' or 'Phoenix,AZ'. Returns current forecast for given location, including next five days and next eight hours.</p>
<p>GET '/api/v1/backgrounds?location={location}'</p>
<p> Location must be sent as 'Denver,CO' or 'Pheonix,AZ'. Returns url of a background image to display for given location</p>
<p>POST '/api/v1/users' </p>
<p>A post request can be sent to the above uri, sending over the email, password, and password confirmation in the body of the request as JSON. If successful, it will return the user's email and the api key they have been issued.</p>
<p>POST '/api/v1/sessions' </p>
<p>A post request can be sent to the above uri, sending over email and password in the body of the request as JSON. If successful, it will return the given user's email and api_key</p>
<p>POST '/api/v1/road_trip' </p>
