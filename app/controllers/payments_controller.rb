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
    

    	ida = params[:seller]
      puts "procesando pagos por el vendedor #{ida}"
	    case params[:amount]
	   		when 100000
	   			id = 'plan_inicial'
	    	when 160000
	    		id = 'plan_avanzado'

	    	when 1000000
	    		id = 'plan_institucional'
	    end

		begin
		 charge = Conekta::Charge.create({
		      amount: params[:amount],
		      currency: 'MXN',
		      description: "payment suscription #{current_user.name} - #{current_user.id} --> vendedor #{ida}",
		      card: params[:conektaTokenId],
		      reference_id: "#{id}"
		  })
      puts '***************Estato del cargo****************'
		  puts charge.status
      puts '*******************************'
          
		rescue Conekta::ParameterValidationError => e
		  puts e.message 
		  flash[:notice] = "Error al intentar pagar algúno de los parámetros es invalido"
		  redirect_to :back
		#alguno de los parámetros fueron inválidos
		rescue Conekta::ProcessingError => e
		  puts e.message 
		  flash[:notice] = "Lo sentimos la tarjeta no pudo ser procesada"
		  redirect_to :back
		#la tarjeta no pudo ser procesada
		rescue Conekta::Error
		  puts e.message 
		  flash[:notice] = "Lo sentimos el sistema de cobros ha tenido un error inesperado y no ha procesado su pago"
		  redirect_to :back
		#un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
		end
		respond_to do |format|
		  format.html
		end
	end

	def payments
	end


end
