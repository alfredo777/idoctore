class MessageUserToUser < ActiveRecord::Base
	belongs_to :cite_doctor
	belongs_to :user

	after_create do 
		@notice = Notice.create(:user_id => self.user_id,  :receiver_id => self.to_user_id, :typex => 'Message', :typex_id => self.id, :checked => false )
	end
    

end
