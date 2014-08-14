class PaymentsController < ApplicationController
skip_before_filter :verify_authenticity_token  

#################################################################################################
######### Payment Methods ##########
	def send_payment
		if Rails.env == 'development'
	  	  Conekta.api_key = "key_vfTtG9pSzzQp7aFo"
	    else
	   	 Conekta.api_key = "key_vfTtG9pSzzQp7aFo"
	  end
    

    if params[:cupon] != nil
    		id = 'cupon_plan'
    else
	    case params[:amount]
	   		when 1000
	   			id = 'plan_inicial'
	    	when 1600
	    		id = 'plan_avanzado'
	    	when 10000
	    		id = 'plan_institucional'
	    end
    end	

		begin
		 charge = Conekta::Charge.create({
		      amount: params[:amount],
		      currency: 'MXN',
		      description: "payment suscription #{current_user.name} - #{current_user.id}",
		      card: params[:conektaTokenId],
		      reference_id: "#{id}"
		  })
      puts '***************Estato del cargo****************'
		  puts charge.status
      puts '*******************************'

		rescue Conekta::ParameterValidationError => e
		  puts e.message 
		#alguno de los parámetros fueron inválidos
		rescue Conekta::ProcessingError => e
		  puts e.message 
		#la tarjeta no pudo ser procesada
		rescue Conekta::Error
		  puts e.message 
		#un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
		end
		respond_to do |format|
		  format.html
		end
	end

	def payments
	end


end
