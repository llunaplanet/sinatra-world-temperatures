# Homepage (Root path)
get '/' do
  @variable = 'Lorem ipsum'
  erb :index
end

require_relative '../google_geocode'
require_relative '../forecast_io'

get '/:address' do

  @units = "ºC"

  # The last imperial countries in the world
  imperial_countries = ["US", "LR", "MM"]

  # Get location and country code
  googleGeocodeAPI = GoogleGeocodeAPI.new
  location = googleGeocodeAPI.address_to_location(params['address'])
  country_code = googleGeocodeAPI.get_country_code

  country_units = "si"
  if imperial_countries.index(country_code) != nil
      country_units = "us"
      @units = "ºF"
  end

  # Get forecast
  forecastIO = ForecastIO.new(ENV['FORECASTIO_KEY'], country_units)
  forecast = forecastIO.get_forecast(location["lat"], location["lng"])

  @forecast_current_temp = forecast["currently"]["temperature"].round
  @address = params['address']

  erb :temperature

end
