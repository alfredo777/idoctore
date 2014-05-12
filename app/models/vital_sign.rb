class VitalSign < ActiveRecord::Base
	belongs_to :user

	def owner
		if self.owner_by != nil
		@user = User.find(self.owner_by)
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
