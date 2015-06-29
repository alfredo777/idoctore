class PaymentsController < ApplicationController
	skip_before_filter :verify_authenticity_token
  
	#################################################################################################
	######### Payment Methods ##########
	def send_payment
		Conekta.api_key = $coneckta_api_key

    @user = UserRegister.find(session[:registeruser])

    customer = Conekta::Customer.create({
		  name: @user.name.to_s,
		  email: @user.email.to_s,
		  phone: @user.phone.to_s,
		  cards: [params[:conektaTokenId]] 
		})
    puts customer 

    plan_id = session[:payment].gsub(/[^0-9A-Za-z_-]/, '').gsub(' ', '_')

    puts plan_id
    begin
    plan = Conekta::Plan.find(plan_id)
    rescue Conekta::Error => e
      case session[:payment]
        when "idoctore-mensual"
          plan = Conekta::Plan.create({
            id: "idoctore-mensual",
            name: "Plan mensual de idoctore",
            amount: 21000,
            currency: "MXN",
            interval: "month"
          })
        when "idoctore-anual"
          plan = Conekta::Plan.create({
            id: "idoctore-anual",
            name: "Plan anual de idoctore",
            amount: 200000,
            currency: "MXN",
            interval: "year"
          })
      end
    end
    puts plan


    subscription = customer.create_subscription({
        plan_id: plan.id
    })

    puts subscription
    if subscription.status == 'active'
    puts "*************** suscripcción creada correctamente ******************"  
    elsif subscription.status == 'past_due'
    puts "*************** falla al inicializar la suscripcción *****************"
    end

    redirect_to :back

	end

	def payments
	end

	def send_payment_in_cash
		case params[:amount]
		when 230000
			@id = 'plan_inicial'		
		when 400000
			@id = 'plan_unlimited'
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
