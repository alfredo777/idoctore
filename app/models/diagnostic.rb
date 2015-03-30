class Diagnostic < ActiveRecord::Base

	belongs_to :user
    has_many :notes
    has_many :clinical_history_to_diagnostic
    has_many :clinical_histories, through: :clinical_history_to_diagnostic
    
   
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

	def act_owner
	    if self.owner_by != nil
		@user = User.find(self.owner_by)
		if @user != nil
         @owner = @user
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

	def qrcode_exec
		 @qr = RQRCode::QRCode.new(self.qrcode, size: 10)
	end
    		 
    def create_image_qr
		require 'rqrcode/export/svg'
		image = RQRCode::QRCode.new(self.qrcode).as_svg(:module_size => 2)
    end
end
