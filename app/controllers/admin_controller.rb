class AdminController < ApplicationController
  before_filter :admin_filter, only: [:users, :cupons, :payments, :stats ]

  def users
  end

  def cupons
    @cupons = Cupon.paginate(:page => params[:page], :per_page => 120).order('created_at DESC')
  end

  def payments
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

  private
  def admin_filter
    if session[:admin] == nil
      flash[:notice] = 'Necesitas loguearte como administrador para poder ingresar'
      redirect_to admin_loggin_path
    end
  end



end
