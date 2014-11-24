class Location < ActiveRecord::Base
	geocoded_by :ip_address
	after_validation :geocode, :reverse_geocode
	
end
