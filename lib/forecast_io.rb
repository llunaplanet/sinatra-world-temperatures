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
