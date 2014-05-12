class Diagnostic < ActiveRecord::Base
	belongs_to :user
    has_many :notes
   
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

	def signs
		@sign = VitalSign.find(self.vital_signs)
	end 
end
