class HospitalsController < ApplicationController
  
  def view
  end

  def loggin
  end

  def users
  end

  def stats
  end

  def creat_user_hospital
  end

  def delete_user_hospital
  end

  def create_user_by_hospital
  end

  def create_hospital
  	@hospital = Hospital.create(name: params[:name], password: params[:password],phone:  params[:phone])
  	flash[:notice] = "Hospital agregado correctamente:  #{@hospital.name}"
  	redirect_to :back
  end

  def session_in
    @hospital = Hospital.find_by_secure_code(params[:code])
    session_in_hospital(@hospital, params[:password])
  end

private 

  def session_in_hospital(hospital, password)
    sha256 = Digest::SHA256.new
    digest = sha256.update password
    backend_validate = hospital.w_digest(digest)
    puts "#{backend_validate}"

    if  backend_validate == true
      session[:hospital] = "#{hospital.id}"
      redirect_to hospital_path(hospital.id)
      flash[:notice] = "Ha ingresado correctamente"
    else
      session[:hospital] = nil
      flash[:notice] = "El usuario o la contraseña son incorrectos."
      redirect_to root_path
    end
    puts "#{session[:user]}"
  end

end
