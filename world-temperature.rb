#!/usr/bin/env ruby

require 'net/https'
require 'json'

class ForecastIO

    attr_accessor :units
    attr_accessor :api_key

    def initialize(api_key, units = "si")

        # Unit Format
        # "us" - U.S. Imperial
        # "si" - International System of Units
        # "uk" - SI w. windSpeed in mph

        @api_key = api_key
        @units = units
    end

    def get_forecast(latitude, longitude)
        http = Net::HTTP.new("api.forecast.io", 443)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        api_endpoint = "/forecast/#{@api_key}/#{latitude},#{longitude}?units=#{@units}"
        response = http.request(Net::HTTP::Get.new(api_endpoint))
        forecast = JSON.parse(response.body)
        return forecast
    end

end

if __FILE__ == $0

    api_key = "99f08919415972d78b757e13a6fc1345"
    location_lat = "45.429522"
    location_long = "-75.689613"

    forecastIO = ForecastIO.new(api_key)
    forecast = forecastIO.get_forecast(location_lat, location_long)
    forecast_current_temp = forecast["currently"]["temperature"]
    forecast_hour_summary = forecast["minutely"]["summary"]
    puts "Current temperature: #{forecast_current_temp}"
    puts "Text summary: #{forecast_hour_summary}"

    forecastIO.units="us";
    forecast = forecastIO.get_forecast(location_lat, location_long)
    forecast_current_temp = forecast["currently"]["temperature"]
    forecast_hour_summary = forecast["minutely"]["summary"]
    puts "Current temperature: #{forecast_current_temp}"
    puts "Text summary: #{forecast_hour_summary}"

end
