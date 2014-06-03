class CiteDoctor < ActiveRecord::Base
	belongs_to :user

	def capt_requester
		@doctor = User.find(self.doctor_id)
	end
end
