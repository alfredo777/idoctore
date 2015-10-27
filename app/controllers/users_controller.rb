class UsersController < ApplicationController
  require "conekta"
  #################################################################################################

  ########### USER CONTROLLER I DOCTORE ###############


  #################################################################################################
  ############## filters #####################
  before_filter :conf_session, only: [:index, :show, :edit, :mobile_cites_viewver]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :loggin_filter, only: [:index, :show, :edit, :clinical_update]
  before_filter :filter_from_payment, only: [:index, :show, :edit]
  before_filter :filter_to_update, only: [:edit, :actualize]
  before_filter :filter_view_pofile, only: [:show, :diagnostics]
  before_filter :set_cache_buster
  before_filter :confirmed_user, only: [:index, :show, :edit]
  before_filter :suspended_user, only: [:index, :show, :edit]


  #################################################################################################
  ######### views methods ########
  def index
    require 'will_paginate/array'

    #flash[:notice] = nil
    @user_patients = current_user.patients.paginate(:page => params[:page], :per_page => 30)
    @user_doctors = current_user.doctors.paginate(:page => params[:page], :per_page => 30)

  end

  # GET /users/1
  # GET /users/1.json
  def show
    require 'will_paginate/array'
    @user = User.find(params[:id])
    @user_vital_signs = @user.vital_signs.last(5)
    @user_diagnostics = @user.diagnostics.last(5)
    @user_files = @user.single_files.last(5)
    @personal_cites = @user.doctor_cites.last(7)
    @other_cites = @user.cite_doctors.last(7)
    @tasks =  @other_cites + @personal_cites
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @notices = @user.my_request_from_notice.last(5)
    @cronic = @user.diagnostics.where(:chronic => true).count
    @outstanding = @user.diagnostics.where(:outstanding => true).count
    @serious = @user.diagnostics.where(:serious => true).count
    @inconsequential = @user.diagnostics.where(:inconsequential => true).count
  end

  def diagnostics
    @user=User.find(params[:id])
    @diagnostics = @user.diagnostics.paginate(:page => params[:page], :per_page => 10)
    layout_cahnge
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def clear_cache_user
    Rails.cache.clear
    @user = params[:user]
    redirect_to user_path(@user)
  end

  #################################################################################################
  ########### update methods #############
  def actualize
    @user = User.find(params[:id])
    if params[:email] != nil
      @user.email = params[:email]
    end

    if params[:name] != nil
      @user.name = params[:name]
    end

    if params[:birthday] != nil
      @user.birthday = params[:birthday]
    end

    if !params[:password].nil? && !params[:password].empty?
      if params[:password] == params[:confirm_password]
        @user.hashed_password = Digest::SHA2.hexdigest("#{params[:password]}")
      end
    end

    if params[:file] != nil
      @user.avatar = params[:file]
    end
    if params[:left_logo] != nil
      @user.left_logo = params[:left_logo]
    end
    if params[:right_logo] != nil
      @user.right_logo = params[:right_logo]
    end

    if params[:college] != nil
      @user.college = params[:college]
    end

    if params[:cadre_card] != nil
      @user.cadre_card = params[:cadre_card]
    end

    if params[:street_addres] != nil
      @user.street_addres = params[:street_addres]
    end
    if params[:sex] != nil
      @user.sex = params[:sex]
    end

    if params[:specialism] != nil
      @user.specialism = params[:specialism]
    end 

    if params[:phone] != nil
      @user.phone = params[:phone]
    end

    if params[:view_doctor_content] != nil
      @user.view_doctor_content = params[:view_doctor_content]
      else
      @user.view_doctor_content = false
    end

    if params[:dental_clinical_history] != nil
      @user.dental_clinical_history = params[:dental_clinical_history]
      else
      @user.dental_clinical_history =  false
    end

    if params[:dental_module] != nil
      @user.dental_module = params[:dental_module]
      else
      @user.dental_module = false
    end

    if params[:homeopatic_clinical_history] != nil
      @user.homeopatic_clinical_history = params[:homeopatic_clinical_history]
      else
      @user.homeopatic_clinical_history = false
    end

    if params[:acupulture_clinical_history] != nil
      @user.acupulture_clinical_history = params[:acupulture_clinical_history]
      else
      @user.acupulture_clinical_history = false
    end

    if params[:acupulture_module] != nil
      @user.acupulture_module = params[:acupulture_module]
      else
      @user.acupulture_module = false
    end

    if params[:normative_clinical_history] != nil
      @user.normative_clinical_history = params[:normative_clinical_history]
      else
      @user.normative_clinical_history = false
    end
    
    @user.save
    flash[:notice] = 'Se ha actualizado el usuario.'
    if viewver_user != nil
      redirect_to assistans_doctor_show_path(id: viewver_user.id)
    else
      redirect_to user_path(@user.id)
    end
  end


  def clinical_update
    @user = User.find(params[:id])
    if params[:email] == nil
      @user.email = "contacto+"+"#{SecureRandom.hex(10)}"+"@idoctore.com"
      else
      @user.email =  params[:email]
    end

    if params[:name] != nil
      @user.name = params[:name]
    end

    if params[:birthday] != nil
      @user.birthday = params[:birthday]
    end

    if params[:phone] != nil
      @user.phone = params[:phone]
    end

    if params[:ethnic_group] != nil
      @user.ethnic_group = params[:ethnic_group]
    end

    if params[:nationality] != nil
      @user.nationality = params[:nationality]
    end

    if params[:marital_status] != nil
      @user.marital_status = params[:marital_status]
    end

    if params[:occupation] != nil
      @user.occupation = params[:occupation]
    end

    if params[:birthplace] != nil
      @user.birthplace = params[:birthplace]
    end

    if params[:place_of_residence] != nil
      @user.place_of_residence = params[:place_of_residence]
    end

    if params[:home] != nil
      @user.home = params[:home]
    end

    if params[:religion] != nil
      @user.religion = params[:religion]
    end

    if params[:sexual_preference] != nil
      @user.sexual_preference = params[:sexual_preference]
    end

    if params[:number_of_sexual_partners] != nil
      @user.number_of_sexual_partners = params[:number_of_sexual_partners]
    end

    if params[:person_in_charge] != nil
      @user.person_in_charge = params[:person_in_charge]
    end

    if params[:blood_type] != nil
      @user.blood_type = params[:blood_type]
    end


    if validate_accepted_patient(current_user, @user)
      @user.save

      if @user.save
        flash[:notice] = 'Usuario Actualizado correctamente'
        redirect_to clinical_history_path(user: @user.id)
      else
        flash[:notice] = 'El usuario no ha podido ser actualizado de manera correcta'
        redirect_to clinical_history_path(user: @user.id)
      end

    else
      flash[:notice] = 'El usuario no se ha podido actualizar debido a una situación de falta de permisos.'
      redirect_to users_path
    end
  end

  #################################################################################################
  ####### create user methods or invite #########

  def register
    pass_a = "#{params[:password]}"
    pass_b = "#{params[:confirm_password]}"
    if params[:terms] != nil
      if pass_a == pass_b
        @user = User.new
        @user.name = params[:name]
        @user.email = params[:email]
        @user.hashed_password = params[:password]
        @user.sex = params[:sex]
        @user.role = "#{params[:role]}"
        @user.confirmed_token = random_to_token
        @user.confirmed = params[:seller]
        @user.terms = params[:terms]
        @user.cadre_card = params[:cadre_card]
        @user.phone = params[:phone]
          if params[:payment_method]
             @user.payment_method = true
          end
        @user.save
        if @user.save
          if @user.confirmed == true
              flash[:notice] =  'Usuario creado correctamente'
              if session[:admin] != nil
                session[:paymenttouser] = nil
                redirect_to admin_path
              else
                session[:paymenttouser] = @user.id
                redirect_to pay_ment_by_path
              end
              else
               @mailer = UserMailer.welcome_email(@user, @user.confirmed_token).deliver
              flash[:notice] =  t('user.create_user')
              redirect_to sign_in_path
          end
        else
          flash[:notice] = t('user.user_simple_error')
          redirect_to :back

        end
      else
        flash[:notice] = t('user.user_password_error')
        redirect_to :back
      end
    else
      flash[:notice] = t('user.user_non_terms_error')
      redirect_to :back
    end
  end

  def nuevo_paciente
    layout_cahnge
  end

  def create_user_by_invite
    ###### add new user to plataform ####
    @u = User.find_by_email(params[:email])
    if @u != nil
      @dp_find = DoctorPatient.where(:doctor_id => current_user.id, :patient_id => @u.id)

      if @dp_find != nil
        @dp = DoctorPatient.create(:doctor_id => current_user.id, :patient_id => @u.id)

        if current_user.hospitals.count != 0
         @hospital = current_user.hospitals.last
         @create_relation = UserHospital.create(user_id: @u.id, hospital_id: @hospital.id)
        end

        @mailer = UserMailer.existent_user_invite(@u, current_user).deliver
        flash[:notice] = t('user.solicitud_user_by_invite')
        if session[:assistant] == nil
        redirect_to users_path
        else
        redirect_to patients_assistant_path(user: current_user.id)
        end
      else
        flash[:notice] = t('user.error_solicitude_user_by_invite')
        redirect_to :back
      end
    else
      @user_new = User.new
      @user_new.name = params[:name]
      if params[:email] == nil
      @user_new.email = "contacto+"+"#{SecureRandom.hex(10)}"+"@idoctore.com"
      else
      @user_new.email =  params[:email]
      end
      @user_new.phone = params[:phone]
      @user_new.sex = params[:sex]
      @user_new.hashed_password = SecureRandom.hex(20)
      @user_new.role = "patient"
      @user_new.confirmed_token = random_to_token
      @user_new.birthday = params[:birthday]
      @user_new.confirmed = false
      @user_new.save
      ###### add patient to user interface #####
      @dp = DoctorPatient.create(:doctor_id => current_user.id, :patient_id => @user_new.id, :accepted_request => true)
      if @user_new.save
        if current_user.hospitals.count != 0
         @hospital = current_user.hospitals.last
         @create_relation = UserHospital.create(user_id: @user_new.id, hospital_id: @hospital.id)
        end
        @mailer = UserMailer.invite_user_email(current_user ,@user_new, @user_new.confirmed_token).deliver
        #flash[:notice] = t('user.create_user_by_invite')
        flash[:notice] = 'Nuevo paciente agregado'
        if session[:assistant] == nil
        redirect_to users_path
        else
        redirect_to patients_assistant_path(user: current_user.id)
        end

      else
        flash[:notice] = t('user.error_create_user_by_invite')
        redirect_to :back

      end
    end
  end

  def existent_user_recive_invitation
    @invity_by = User.find(params[:secret_key])
    @user.confirmed_token = nil
    @user.save
    flash[:notice] = t('user.existe_user_invite_accepted')
    redirect_to user_path(@user)
  end

  def actualize_invitation_non_mail
    @invite = DoctorPatient.find_by_doctor_id_and_patient_id(params[:doctor],current_user.id)
    @invite.accepted_request = true
    @invite.save
    flash[:notice] = 'Has aceptado al usuario en tu lista de doctores.'
    redirect_to :back
  end

  def delete_relation_doctor_patient
    case current_user.role
    when 'patient'
      @invite = DoctorPatient.find_by_doctor_id_and_patient_id(params[:other],current_user.id)
    when 'doctor'
      @invite = DoctorPatient.find_by_doctor_id_and_patient_id(current_user.id,params[:other])
    end
    @invite.destroy
    flash[:notice] = 'Se ha eliminado correctamente la relación.'
    redirect_to :back
  end



  def confirmed_token
    @user = User.find_by_confirmed_token(params[:confirmed_token])
    puts "#{@user}"
    @user.confirmed_token = nil
    @user.confirmed = true
    @user.save
    flash[:notice] = t('user.confirmed_token')
    if @user != nil
      redirect_to sign_in_path
    else
      redirect_to root_path
    end
  end

  #################################################################################################
  ######## password methods ##########

  def reset_password
    @user = User.find_by_confirmed_token(params[:confirmed_token])
    puts "#{@user}"
    @user.confirmed_token = nil
    @user.confirmed = true
    @user.terms = true
    @user.save

    @dp = DoctorPatient.find_by_patient_id(@user.id)
    if @dp != nil
        @dp.accepted_request = true
        @dp.save
    end

    flash[:notice] = t('user.reset_password')

    respond_to do |format|
      format.html
    end
  end

  def missing_password

  end

  def change_missing_password
    @user = User.find_by_email(params[:email])
    if @user != nil
    @user.confirmed_token = random_to_token
    @user.save
    @mailer = UserMailer.missing_password(@user, @user.confirmed_token).deliver
    flash[:notice] = t('user.mail_to_change_password')
    redirect_to root_path
    else
    flash[:notice] = "No ha sido posible encontrar el usuario"
    redirect_to :back
    end
  end

  def change_password
    @user = User.find(params[:id])
    @user.hashed_password = Digest::SHA2.hexdigest("#{params[:password]}")
    @user.save
    if @user.save
      flash[:notice] = t('user.satify_change_password')
      redirect_to sign_in_path
    else
      flash[:notice] =  t('user.password_non_safe')
      redirect_to :back
    end
  end

  #################################################################################################
  #### methos for cites ##########

  def send_request_cite
    date =  params[:init_time_date] + ' ' + params[:init_time_hour] + ':00'
    date = DateTime.parse( date )
    case  current_user.role
    when 'doctor'
      ###### cite auto confirmed #####
      @cite = CiteDoctor.create( init_time: date, request: params[:request], confirmed_by_doctor: true, user_id: params[:user_id], doctor_id: params[:doctor_id])
      date2 = @cite.init_time + 50.minutes
      @cite.finish_time = date2
      @cite.save
    when 'patient'
      ###### cite not confirmed solicite by other #######
      @cite = CiteDoctor.create( init_time: date, request: params[:request], confirmed_by_doctor: false, user_id: current_user.id, doctor_id: params[:doctor_id])
      date2 = @cite.init_time + 50.minutes
      @cite.finish_time = date2
      @cite.save
    end

    if @cite.save
      flash[:notice] = 'Se a solicitado la cita correctamente.'
      redirect_to :back
    end
  end

  def responce_cite
    @cite = CiteDoctor.find(params[:ident_i])
    @cite.confirmed_by_doctor = true
    @cite.save

    respond_to do |format|
      format.js
    end
  end


  def options_change_cite
    @cite = CiteDoctor.find(params[:ident_i])
    @type = params[:type]
    @messages = @cite.message_user_to_users.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')

    respond_to do |format|
      format.js
    end
  end

  def update_cites
    @cite = CiteDoctor.find(params[:id])
    date =  params[:init_time_date] + ' ' +params[:init_time_hour]
    @cite.init_time = date
    date2 = @cite.init_time + 50.minutes
    @cite.finish_time = date2
    @cite.save

    if @cite.save
      flash[:notice] = 'Se a actualizado la cita correctamente.'
      redirect_to :back
    else
      flash[:notice] = 'Cambios no actualizados.'
      redirect_to :back
    end

  end

  def cancel_cite
    @cite = CiteDoctor.find(params[:ident_i])
    @cite.destroy
    redirect_to :back
  end

  def all_cites_viwer
    require 'will_paginate/array'
    @user = current_user
    @personal_cites = @user.doctor_cites
    @other_cites = @user.cite_doctors
    @tasks =  @other_cites + @personal_cites
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @notices = @user.my_request_from_notice.last(15)
  end

  def mobile_cites_viewver
    require 'will_paginate/array'
    @user = User.find(params[:id])
    @personal_cites = @user.doctor_cites
    @other_cites = @user.cite_doctors
    @tasks =  @other_cites + @personal_cites
    @tasks = @tasks.paginate(:page => params[:page], :per_page => 15)
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @notices = @user.my_request_from_notice.last(15)
  end

  #################################################################################################
  ######### session methods ############
  def create_session
    @user = User.find_by_email(params[:email])
    if @user != nil
      if @user.terms == true
        password_cript(params[:password], @user)
      else
        flash[:notice] = t('user.non_terms_accepted')
        redirect_to root_path
      end
      else
        flash[:notice] = "Ha ocurrido un error no ha sido posible encontrar el usuario"
      redirect_to :back  
    end
  end

  def destroy_session
    @activity = UserActivity.create(user: current_user, activity: 'logout')
    session[:user] = nil
    redirect_to root_path
  end

  def session_new
    render layout: 'session_new'
  end
  #################################################################################################
  #### crear notificaciones

  def create_notice_cite
  end

  #################################################################################################
  ######## methods from delete #########

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  #################################################################################################
  ######### Admin Methods ##########

  def admin_user_loggin
    @admin = ManagerUser.find_by_email(params[:email])
    @pass = params[:password]
    @iden = params[:identify]
    if @admin
      password_cript_admin(@pass, @admin, @iden)
    else
      flash[:notice] = 'No se ha encontrado el usuario'
      redirect_to :back
    end
  end

  def admin_user_create
  end

  def admin_user_destroy
  end

  def admin_user_cupons
    printing = SecureRandom.hex(9)
    identify = params[:identify]
    params[:quanty].to_i.times do
      @cupon = Cupon.create(indentifier_random: SecureRandom.hex(4), institution: params[:institution], used: false, printing: printing, manager_user_id: session[:admin], assigned: identify, price: params[:price] )
    end

    if @cupon.save
      flash[:notice] = 'Cupónes creados correctamente'
    else
      flash[:notice] = 'Cupónes no creados'
    end

    redirect_to admin_cupons_path
  end

  def search_cupons
    @cupons = Cupon.where(printing: params[:printing])
    respond_to do |format|
      format.js
    end
  end
  


  #################################################################################################
  ####### private methods #########
  private

  #### change layout
  def layout_cahnge
    if session[:assistant] != nil
      render layout: "assistants"
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  #################################################################################################
  ######## filtros ###########
  def filter_to_update
    if viewver_user == nil 
      @user = User.find(params[:id])
      if @user.id ==  current_user.id
        # flash[:notice] = 'Bienbenido al editor de usuario.'
      else
        flash[:notice] = 'Usted no esta autorizado para editar este usuario.'
        redirect_to user_path(@user.id)
      end
    end
  end

  def filter_from_payment
    if Rails.env == 'production'
      if current_user.role == 'doctor'
        if current_user.payment_method
          puts "pagado"
        else
          redirect_to payments_path
        end
      end
    end
  end

  def filter_view_pofile
    @user = User.find(params[:id])
    if session[:assistant] == nil
      if current_user.id == @user.id
      else
        if validate_accepted_patient(current_user, @user)
          #flash[:notice] = "Bienbenido al perfíl de tu paciente #{@user.name}"
        else
          flash[:notice] = 'El  usuario al que intentabas ingresar no es tu paciente.'
          redirect_to user_path(current_user.id)
        end
      end
    else
      if request.fullpath.split("?")[0] != diagnostics_users_path(@user.id)
      redirect_to assistans_doctor_show_path(id: viewver_user.id)
      end
    end
  end

  def conf_session
    if session[:assistant] == nil
      if session[:user] == nil
        session[:user] = nil
         flash[:notice] = "Inicie un sessión para continuar" 
         redirect_to root_path
      end
    end
  end

  def confirmed_user
    if current_user.confirmed == false
      session[:user] = nil
      flash[:notice] = "Su usuario no ha sido confirmado" 
      redirect_to root_path
    end
  end

  def suspended_user
    if current_user.suspend == true
      session[:user] = nil
      flash[:notice] = "Tu usuario se encuentra suspendido contactanos para ayudarte."
      redirect_to root_path
    end
  end
  #########################################################################################
  ############# validadores de password ##################
  def password_cript(password, member)
    sha256 = Digest::SHA256.new
    digest = sha256.update password
    backend_validate = member.w_digest(digest)
    puts "#{backend_validate}"

    if backend_validate == true
      session[:user] = "#{member.id}"
      redirect_to user_path(member.id)
      @activity = UserActivity.create(user: current_user, activity: 'login')
      flash[:notice] = t('user.create_session')
    else
      session[:user] = nil
      flash[:notice] = "El usuario o la contraseña son incorrectos."
      redirect_to root_path
    end
    puts "#{session[:user]}"
  end


  def password_cript_admin(password, admin, identify )
    puts password
    puts admin
    puts identify
    sha256 = Digest::SHA256.new
    digest = sha256.update password
    puts digest
    backend_validate = admin.reciber_params_loggin(digest, identify)
    puts "#{backend_validate}"

    if  backend_validate == true
      session[:admin] = "#{admin.id}"
      redirect_to admin_path
      flash[:notice] = t('user.create_session')
    else
      session[:admin] = nil
      flash[:notice] = "El usuario o la contraseña son incorrectos."
      redirect_to admin_loggin_path
    end
    puts "#{session[:admin]}"
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    response.headers.delete('X-Frame-Options')
  end

end
