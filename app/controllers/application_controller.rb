class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :session_status
  helper_method :validate_accepted_patient
  helper_method :status_if_request_patient_doctor_exist
  helper_method :random_to_token
  helper_method :find_advance_key


  def current_user
  	@iuser = User.find(session[:user]) if session[:user] != nil
  end

  def session_status
  	if session[:user] == nil
  		@status = false
  	else
  		@status = true
  	end
  end

  def loggin_filter
  	unless session_status
  	 	redirect_to root_path
  	 end  
  end
  
  def validate_accepted_patient(im, other)

   case current_user.role 
     when'patient'
         @dp = DoctorPatient.find_by_doctor_id_and_patient_id(other.id,im.id)

     when 'doctor'
         @dp = DoctorPatient.find_by_doctor_id_and_patient_id(im.id,other.id)
         
   end

    if @dp != nil
       @dp.accepted_request
      else
       false
    end

  end

  def status_if_request_patient_doctor_exist(im, other)
   case current_user.role 
     when'patient'
      @dp = DoctorPatient.find_by_doctor_id_and_patient_id(other.id,im.id)

      if @dp != nil
       @n = '<a href="/local_confirm_relation?doctor='+"#{other.id}"+'"><span class="label">Aceptar solicitud</span></a>'
       else
       @n = "<a data-reveal-id="+"modal_#{other.id}"+"><span class=' patient_#{other.id} secondary label '"+"id=#{other.id}"+">No hay solicitud (Add) </span></a>"
      end

     when 'doctor'
     @dp = DoctorPatient.find_by_doctor_id_and_patient_id(im.id,other.id)
     if @dp != nil
       @n = '<span class="label"> Solicitud enviada </span>'
       else
       @n = "<a data-reveal-id="+"modal_#{other.id}"+"><span class=' patient_#{other.id} secondary label '"+"id=#{other.id}"+">No hay solicitud (Add) </span></a>"
     end
   end
  end
  
  def random_to_token
     o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
     rand = (0...50).map { o[rand(o.length)] }.join
     string = rand
  end

  def find_advance_key(id)
    @user = User.find(id)
    @user.create_adanced_key
    @user.advanced_key
  end



end
