class Location < ActiveRecord::Base
	geocoded_by :ip_address
	after_validation :geocode
    

    def ubicate_in
    	Geocoder.search("#{self.latitude},#{self.longitude}")
    end
end
