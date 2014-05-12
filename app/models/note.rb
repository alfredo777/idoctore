class Note < ActiveRecord::Base
	belongs_to :user
	belongs_to :diagnostic

	def vital_signs
		@vs = VitalSign.find(self.last_signs)
	end

end
