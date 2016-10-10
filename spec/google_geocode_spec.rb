require './lib/google_geocode'

describe GoogleGeocodeAPI do

    it "Should get an empty response with malformed request" do

        googleGeocodeAPI = GoogleGeocodeAPI.new()
        location = googleGeocodeAPI.address_to_location("val en cia")
        expect(location).to eq nil
    end

    it "Should respond with correct coordinates for Valencia" do

        valencia_location = Hash["lat" => 39.4699075, "lng" => -0.3762881]

        googleGeocodeAPI = GoogleGeocodeAPI.new()
        location = googleGeocodeAPI.address_to_location("valencia")
        expect(location["lat"]).to eq valencia_location["lat"]
        expect(location["lng"]).to eq valencia_location["lng"]

    end

    it "Should return the formatted_address for Valencia" do

        valencia_location = Hash["lat" => 39.4699075, "lng" => -0.3762881]

        googleGeocodeAPI = GoogleGeocodeAPI.new()
        location = googleGeocodeAPI.address_to_location("valencia")
        formatted_address = googleGeocodeAPI.get_formatted_addres()
        expect(formatted_address).to eq "Valencia, Spain"

    end

    it "Should respond with correct country code for Valencia" do

        googleGeocodeAPI = GoogleGeocodeAPI.new()
        googleGeocodeAPI.address_to_location("valencia")
        country_code = googleGeocodeAPI.get_country_code
        expect(country_code).to eq "ES"

    end

    it "Should respond with correct country code for Boston" do

        googleGeocodeAPI = GoogleGeocodeAPI.new()
        googleGeocodeAPI.address_to_location("Boston")
        country_code = googleGeocodeAPI.get_country_code
        expect(country_code).to eq "US"

    end
end
