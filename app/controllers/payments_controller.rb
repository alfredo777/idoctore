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
												description: "payment suscription #{current_user.name} - #{current_user.id} --> vendedor #{ida}",
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
			@p = Payment.create(user_id: current_user.id, payment_global: session[:valuexx].to_i, bank_commission: session[:comission], final_comission: session[:comission_seller], init: Time.now, expire: session[:expiration_ii], comissionpay: false, seller_code: session[:seller], method: 'Card', token_pay: session[:acte])
			puts "#{@p}"
			puts '********************'
			if @p.save
				session[:acte] = nil
				session[:value] = nil
				session[:comission] = nil
				session[:expiration_ii] = nil
				session[:comission_seller] = nil
				session[:seller]= nil
				session[:status_payment] = nil
				current_user.update_attributes(payment_method: true)
				flash[:notice] = 'Pago procesado'

			end
		else
			flash[:notice] = 'Pago no procesado'
		end
		respond_to do |format|
			format.html
		end
	end

	def payments
	end


end
