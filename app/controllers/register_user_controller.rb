class RegisterUserController < ApplicationController
  layout 'layout_not_login'
  def select_plan
    session[:payment] = params[:payment]
    session[:paymenttype] = params[:paymenttype]
    
    if params[:paymenttype] == 'credito'
      session[:steap] = 3
    else
      session[:steap] = 21
    end

    redirect_to register_user_by_steaps_path
  end

  def insert_user_data
    @user = UserRegister.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.sex = params[:sex]
    @user.terms = params[:terms]
    @user.cadre_card = params[:cadre_card]
    @user.phone = "#{params[:phone]}"
    @user.save
    session[:registeruser] = @user.id
    session[:steap] = 2

    redirect_to register_user_by_steaps_path
  end

  def insert_payment_data

  end

  def registration_user

  end
end
