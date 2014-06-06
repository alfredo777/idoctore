class MessageUserToUser < ActiveRecord::Base
	belongs_to :cite_doctor
	belongs_to :user
    

end
