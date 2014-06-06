class CiteDoctor < ActiveRecord::Base
	belongs_to :user
	has_many :message_user_to_users

	def capt_requester
		@doctor = User.find(self.doctor_id)
	end
end
