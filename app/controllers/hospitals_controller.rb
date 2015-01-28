class HospitalsController < ApplicationController
  layout 'hospital'
  before_filter :filter_session, only: [:view, :users, :stats, :create_user_hospital, :create_user_by_hospital, :delete_user_hospital]
  def view
    @hospital = Hospital.find(session[:hospital])
    hospital_loggins = []
    @date = Date.today - 19.days
    20.times do 
      @sessions_in = sessionindate(@date)
      hospital_loggins.push(["#{@date}", @sessions_in]) 
      @date = @date + 1.day
    end

    @hospital_loggins = hospital_loggins

    puts "#{@hospital_loggins}"

  end

  def loggin
    if session[:hospital]
      redirect_to hospital_path
    end
  end
  
  def delete_realtion
    @relation = UserHospital.find_by_hospital_id_and_user_id(session[:hospital], params[:user])
    @relation.destroy
    redirect_to :back
  end

  def users
    @hospital = Hospital.find(session[:hospital])
    @doctors = @hospital.users.where(role: 'doctor').paginate(:page => params[:page], :per_page => 30).order('id DESC')

  end

  def patients
    @hospital = Hospital.find(session[:hospital])
    @patients = @hospital.users.where(role: 'patient').paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end

  def diagnostics
    @hospital = Hospital.find(session[:hospital])
    @user=User.find(params[:id])
    @diagnostics = @user.diagnostics.paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end

  def stats
    @hospital = Hospital.find(session[:hospital])

  end

  def create_user_hospital
    @hospital = Hospital.find(session[:hospital])

  end

  def delete_user_hospital
    @hospital = Hospital.find(session[:hospital])

  end

  def create_user_by_hospital
    @hospital = Hospital.find(session[:hospital])
    @user = User.find_by_email(params[:email])

     if @user != nil
        @create_relation = UserHospital.create(user_id: @user.id, hospital_id: @hospital.id)
        puts "********************** #{ @create_relation } ********************************"
       else 
        @pass = SecureRandom.hex(5)
        @user = User.create(name: params[:name], email: params[:email], hashed_password: @pass, confirmed: true, sex: params[:sex],role: 'doctor', terms:true , cadre_card: params[:cedula], date_of_birth: params[:birthday] )
        @create_relation = UserHospital.create(user_id: @user.id, hospital_id: @hospital.id)
        puts "********************** #{ @create_relation } ********************************"

     end

     flash[:notice] = "Se ha agregado correctamente el usuario"


    redirect_to admin_doctor_hospital_path

  end

  def create_hospital
  	@hospital = Hospital.create(name: params[:name], password: params[:password],phone:  params[:phone])
  	flash[:notice] = "Hospital agregado correctamente:  #{@hospital.name}"
  	redirect_to :back
  end

  def session_in
    @hospital = Hospital.find_by_secure_code(params[:code])
    case 
     when params[:code].blank?
       flash[:notice] = "No has ingresado el código de hospital"
       redirect_to :back

     when params[:password].blank?
       flash[:notice] = "Se ha originado un error debido a que no a colocado su contraseña"
       redirect_to :back

      else
        session_in_hospital(@hospital, params[:password])
    end
  end

  def session_out
    session[:hospital] = nil
    redirect_to login_hospital_path
  end

private 

  def filter_session
    if session[:hospital] == nil
       redirect_to login_hospital_path
    end
  end

  def sessionindate(date)
     counter = 0
     @hospital.users.each do |user|
       user.user_activities.where(activity: 'login').each do |usact|
         if usact.created_at.strftime('%F') == date.strftime('%F')
          counter  =  counter + 1
         end
       end
     end
     counter 
  end

  def session_in_hospital(hospital, password)
    sha256 = Digest::SHA256.new
    digest = sha256.update password
    backend_validate = hospital.w_digest(digest)
    puts "#{backend_validate}"

    if  backend_validate == true
      session[:hospital] = "#{hospital.id}"
      redirect_to hospital_path
      flash[:notice] = "Ha ingresado correctamente"
    else
      session[:hospital] = nil
      flash[:notice] = "El usuario o la contraseña son incorrectos."
      redirect_to login_hospital_path
    end
    puts "#{session[:user]}"
  end

end
