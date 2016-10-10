#!/usr/bin/env ruby

require 'net/https'
require 'json'

class GoogleGeocodeAPI

    def initialize()
        @geocode_result = nil
        @location = nil
        @country_code = nil
    end

    def address_to_location(address)

        @location = nil
        @geocode_result = nil

        http = Net::HTTP.new("maps.googleapis.com", 80)
        address_urlencoded = URI::encode(address)
        api_endpoint = "/maps/api/geocode/json?address=#{address_urlencoded}&sensor=false"
        response = http.request(Net::HTTP::Get.new(api_endpoint))
        geocode_response = JSON.parse(response.body)

        if geocode_response['status'].eql? "OK"

            # Get the first result
            geocode_response['results'].each do |result|
                @geocode_result = result
                break
            end

            extract_location
        end

        return @location

    end

    def extract_location
        if @geocode_result.key?("geometry")
            @location = @geocode_result['geometry']['location']
        end
    end

    def get_country_code

        @country_code = nil

        if @geocode_result.key?("address_components")

            # Try to get the country code
            @geocode_result['address_components'].each do |address|

                if address['types'].include? "country"
                    @country_code = address['short_name']
                    break
                end
            end
        end

        return @country_code

    end

    def get_formatted_addres
      return @geocode_result.key?("formatted_address") ? @geocode_result['formatted_address'] : nil
    end
end
