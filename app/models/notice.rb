class Notice < ActiveRecord::Base
	belongs_to :user
    

    def congruence
    	case self.typex
    	when 'Message'
    	  @var = MessageUserToUser.find(self.typex_id)
    	end
     @var
    end
end
