class SingleFile < ActiveRecord::Base
	mount_uploader :archive, SingleFileUploader 
	belongs_to :user

	def owner
		if self.owner_id != nil
		@user = User.find(self.owner_id)
		if @user != nil
         @owner = @user.name
	    else
          @owner = 'No hay owner'
	    end
	    else
	      @owner = 'No hay owner'
	    end
	end
end
