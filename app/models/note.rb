class Note < ActiveRecord::Base
	belongs_to :user
	belongs_to :diagnostic

	def vital_signs
		if VitalSign.exists?(self.last_signs)
		@vs = VitalSign.find(self.last_signs)
	   else
	   	@vs = nil
	   end
	end

end
