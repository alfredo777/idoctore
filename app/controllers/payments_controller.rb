class PaymentsController < ApplicationController
skip_before_filter :verify_authenticity_token  

#################################################################################################
######### Payment Methods ##########
	def send_payment
    Conekta.api_key = "key_vfTtG9pSzzQp7aFo"

		 charge = Conekta::Charge.create({
		      amount: 1000,
		      currency: 'MXN',
		      description: "Delivery Pizza",
		      card: params[:conektaTokenId],
		      reference_id: "plan_inicial"
		  })

		   puts charge.inspect

		respond_to do |format|
		  format.html
		end
	end

	def payments
	end


end
