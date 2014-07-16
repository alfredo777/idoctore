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
