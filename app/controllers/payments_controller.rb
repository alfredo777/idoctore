class PaymentsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	#################################################################################################
	######### Payment Methods ##########
	def send_payment
		if Rails.env == 'development'
			Conekta.api_key = "key_vfTtG9pSzzQp7aFo"
		else
			Conekta.api_key = "key_6mcfLKFMWkGTCvc7"
		end


		ida = params[:seller]
		puts "procesando pagos por el vendedor #{ida}"
		case params[:amount]
		when 100000
			@id = 'plan_inicial'
		when 160000
			@id = 'plan_avanzado'
		when 1000000
			@id = 'plan_institucional'
		end
		session[:valuexx] = (params[:amount].to_i / 100).to_i
		session[:acte] = params[:conektaTokenId]
		puts "#{session[:acte]}"
		puts "#{session[:valuexx]}"
		session[:comission] = (session[:valuexx].to_i/100) * 3
		puts "#{session[:comission]}"
		session[:expiration_ii] = Time.now + 367.days
		puts "#{session[:expiration_ii]}"
		session[:comission_seller] = (session[:valuexx].to_i/100) * 25
		puts "#{session[:comission_seller]}"
		session[:seller]= ida
		puts "#{session[:seller]}"
		begin
			charge = Conekta::Charge.create({
												amount: params[:amount],
												currency: 'MXN',
												description: "payment suscription --> vendedor #{ida}",
												card: params[:conektaTokenId],
												reference_id: "#{@id}"
			})
			session[:status_payment] = charge.status
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
		if session[:status_payment] == 'paid'
			puts '******************** REGISTRANDO PAGO *******************'
			if session[:paymenttouser] != nil
			 @p = Payment.create(user_id: session[:paymenttouser].to_i, payment_global: session[:valuexx].to_i, bank_commission: session[:comission], final_comission: session[:comission_seller], init: Time.now, expire: session[:expiration_ii], comissionpay: false, seller_code: session[:seller], method: 'Card', token_pay: session[:acte])  
			else
			 @p = Payment.create(user_id: current_user.id, payment_global: session[:valuexx].to_i, bank_commission: session[:comission], final_comission: session[:comission_seller], init: Time.now, expire: session[:expiration_ii], comissionpay: false, seller_code: session[:seller], method: 'Card', token_pay: session[:acte])
		    end
			puts "#{@p}"
			puts '********************'
			if @p.save
				if session[:paymenttouser] != nil
			     @user = User.find(session[:paymenttouser])
                 @user.update_attributes(payment_method: true)
                else
				 current_user.update_attributes(payment_method: true)
			    end
				session[:acte] = nil
				session[:value] = nil
				session[:comission] = nil
				session[:expiration_ii] = nil
				session[:comission_seller] = nil
				#session[:seller]= nil
				session[:status_payment] = nil
				flash[:notice] = 'Pago procesado'
				@m = ManagerUser.find_by_seller_code(session[:seller])
				session[:seller] = @m.id

			end
		else
			flash[:notice] = 'Pago no procesado'
		end
		if session[:paymenttouser] != nil
			session[:paymenttouser] = nil
		    redirect_to seller_path
		else
		respond_to do |format|

			format.html
		end
	    end

	end

	def payments
	end

	def send_payment_in_cash
		case params[:amount]
		when 100000
			@id = 'plan_inicial'
		when 160000
			@id = 'plan_avanzado'
		when 1000000
			@id = 'plan_institucional'
		end

		@global = (params[:amount].to_i / 100).to_i
		@comission = (@global.to_i/100) * 3
		@comission_seller = (@global.to_i/100) * 25
		@expire = Time.now + 367.days

	    @p = Payment.create(user_id: session[:paymenttouser].to_i, payment_global: @global.to_i, bank_commission: @comission, final_comission: @comission_seller, init: Time.now, expire: @expire, comissionpay: false, seller_code: params[:seller], method: 'Cash', token_pay: 'no token')
	    if @p.save
	    	 puts session[:paymenttouser]
	    	 @user = User.find(session[:paymenttouser])
             @user.update_attributes(payment_method: true)
             session[:paymenttouser] = nil
             flash[:notice] = 'Pago realizado'
		     redirect_to seller_path
	    else
	    	 flash[:notice] = 'Pago fallido'
             redirect_to :back
        end
       
	end

end
