class PaymentsController < ApplicationController
	skip_before_filter :verify_authenticity_token
  
	#################################################################################################
	######### Payment Methods ##########
	def send_payment
		Conekta.api_key = $coneckta_api_key

    @user = UserRegister.find(session[:registeruser])
   #cards: [params[:conektaTokenId]]
   #cards: ["tok_test_visa_4242"]
    customer = Conekta::Customer.create({
		  name: @user.name.to_s,
		  email: @user.email.to_s,
		  phone: @user.phone.to_s,
      cards: ["tok_test_visa_4242"]

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
            amount: (210.to_f * 100).to_i,
            currency: "MXN",
            interval: "month",
            frequency: 1,
            trial_period_days: 10,
            expiry_count: 24})
        when "idoctore-anual"
          plan = Conekta::Plan.create({
            id: "idoctore-anual",
            name: "Plan anual de idoctore",
            amount: (2000.to_f * 100).to_i,
            currency: "MXN",
            interval: "year",
            frequency: 1,
            trial_period_days: 10,
            expiry_count: 24
          })
      end
    end
    
    puts plan.inspect

    puts "******************#{plan}"
    subscription = customer.create_subscription({
        plan: plan.id
    })

    puts subscription
    if subscription.status == 'active'
      puts "*************** suscripcción creada correctamente ******************" 
      session[:steap] = 4
      create_user_by_payment(@user.name, @user.email, @user.password, @user.sex, @user.cadre_card, @user.phone)
    elsif subscription.status == 'past_due'
      puts "*************** falla al inicializar la suscripcción *****************"
      flash[:notice] = "Error al crear la suscripcción vuelva a intetarlo, si el problema persiste contactenos"
    end

    if subscription.status == 'in_trial'
      session[:steap] = 4
      create_user_by_payment(@user.name, @user.email, @user.password, @user.sex, @user.cadre_card, @user.phone)
    end    
	end

	def payments
	end
  
  def create_user_by_payment(name, email, password, sex, cadre_card, phone)
    user = User.find_by_email(email)
    if user.nil?
    user = User.create(name: name, email: email, hashed_password: password, terms: true, sex: sex, role: 'doctor', cadre_card: cadre_card, payment_method: true)
    user = UserRegister.find(session[:registeruser])
    user.destroy
    redirect_to register_user_by_steaps_path
    else
    user = UserRegister.find(session[:registeruser])
    user.destroy
    session[:steap] = nil
    flash[:notice] = "El usuario que esta intentado crear ya existe"
    redirect_to register_user_by_steaps_path
    end
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
