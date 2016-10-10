require './lib/forecast_io'

describe ForecastIO do
    it "Should respond by default with SI units" do

        api_key = "99f08919415972d78b757e13a6fc1345"
        location_lat = "45.429522"
        location_long = "-75.689613"

        forecastIO = ForecastIO.new(api_key)
        forecast = forecastIO.get_forecast(location_lat, location_long)
        # forecast.each{|k, v| puts k}
        expect(forecast["flags"]['units']).to eq "si"
    end

    it "Should respond with US units" do

        api_key = "99f08919415972d78b757e13a6fc1345"
        location_lat = "45.429522"
        location_long = "-75.689613"

        forecastIO = ForecastIO.new(api_key,"us")
        forecast = forecastIO.get_forecast(location_lat, location_long)
        # forecast.each{|k, v| puts k}
        expect(forecast["flags"]['units']).to eq "us"
    end
end
