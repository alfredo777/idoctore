class AdminController < ApplicationController
  before_filter :admin_filter, only: [:users, :cupons, :payments, :stats ]
  before_filter :seller_filter, only: [:sellers_window]
  before_filter :second_steap_filter, only: [:pay_ment_by]

  def users
    @users = User.paginate(:page => params[:page], :per_page => 50).order('created_at DESC')
  end

  def cupons
    @cupons = Cupon.paginate(:page => params[:page], :per_page => 120).order('created_at DESC')
  end

  def payments
    @payments = Payment.paginate(:page => params[:page], :per_page => 50).order('created_at DESC')
  end

  def stats
    @date = Date.today
    @yesterday = @date - 1.day
    @users = User.count
    @users_yesterday = User.where(created_at: @yesterday).count
    @users_now = User.where(created_at: @date).count
    @doctors = User.where(role: 'doctor').count
    @patients = User.where(role: 'patient').count
    @cronic = Diagnostic.where(:chronic => true).count
    @outstanding = Diagnostic.where(:outstanding => true).count
    @serious = Diagnostic.where(:serious => true).count
    @inconsequential = Diagnostic.where(:inconsequential => true).count
    @t_diagnostics = Diagnostic.count
  end

  def loggin
  end

  def end_session
    session[:admin] = nil
    redirect_to root_path
  end

  def suspend_user
    @user = User.find(params[:id])
    if @user.suspend 
      @user.suspend = false
    else
      @user.suspend = true
    end

    @user.save

    redirect_to :back
  end

  def create_user_by_payment_methods
  end

  def pay_ment_by
    @user = User.find(session[:paymenttouser])
    @seller = ManagerUser.find(session[:seller])
  end

  def sellers_window
    @seller = ManagerUser.find(session[:seller])
    @payments = Payment.where(seller_code: @seller.seller_code)
  end

  def acces_window
     if session[:seller] != nil
      redirect_to sellers_window_path
     end
  end

  def acces_window_validate
   @s = ManagerUser.find_by_seller_code(params[:seller_code])
   if @s
   session[:seller] = @s.id
   flash[:notice] = "Bienbenido al panel de vendedor"
   redirect_to seller_path
   else
    flash[:notice] = "El vendedor al que esta intentando ingresar no existe"
    redirect_to :back
    
   end
   
  end

  def exit_seller
    session[:seller] = nil
    redirect_to acces_window_path
  end

  private
  def admin_filter
    if session[:admin] == nil
      flash[:notice] = 'Necesitas loguearte como administrador para poder ingresar'
      redirect_to admin_loggin_path
    end
  end

  def seller_filter
    if session[:seller].nil?
      redirect_to acces_window_path
    end
  end

  def second_steap_filter
    unless session[:paymenttouser] 
      redirect_to create_user_by_payment_methods_path
    end
  end



end
