#!/usr/bin/env ruby

require 'net/https'
require 'json'

# Forecast API Key from https://developer.forecast.io
forecast_api_key = "99f08919415972d78b757e13a6fc1345"

# Latitude, Longitude for location
forecast_location_lat = "45.429522"
forecast_location_long = "-75.689613"

# Unit Format
# "us" - U.S. Imperial
# "si" - International System of Units
# "uk" - SI w. windSpeed in mph
forecast_units = "si"

# SCHEDULER.every '5m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.forecast.io", 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  api_endpoint = "/forecast/#{forecast_api_key}/#{forecast_location_lat},#{forecast_location_long}?units=#{forecast_units}"
  response = http.request(Net::HTTP::Get.new(api_endpoint))
  forecast = JSON.parse(response.body)
  forecast_current_temp = forecast["currently"]["temperature"].round
  forecast_hour_summary = forecast["minutely"]["summary"]
  #send_event('forecast', { temperature: "#{forecast_current_temp}&deg;", hour: "#{forecast_hour_summary}"})
  puts "Current temperature: #{forecast_current_temp}"
  puts "Forecast summary: #{forecast_hour_summary}"
  puts forecast
# end
