class AdminController < ApplicationController
  before_filter :admin_filter, only: [:users, :cupons, :payments, :stats ]
 
  def users
  end

  def cupons
  end

  def payments
  end

  def stats
  end

  def loggin
  end

private
  def admin_filter
  	if session[:admin] == nil
  	  flash[:notice] = 'Necesitas loguearte como administrador para poder ingresar'
      redirect_to admin_loggin_path
  	end
  end

end
