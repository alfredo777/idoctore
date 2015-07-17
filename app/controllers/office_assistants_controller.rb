class OfficeAssistantsController < ApplicationController
  before_filter :loggin_filter, only: [:new ,:add_assistant_by_doctor, :remove_assistant ]
  before_filter :loggin_filter_in_assitant, only: [:doctors, :cites, :messages, :add_doctor_to_assistant, :remove_doctor, :doctor, :edit_doctor, :edit_assistant, :patients ]
  layout "assistants", only: [:doctors, :cites, :messages, :add_doctor_to_assistant, :remove_doctor, :doctor, :edit_doctor, :edit_assistant, :patients ]
  helper_method :assistant_permissioning
  def login
    unless session[:assistant] == nil
      redirect_to assistans_doctor_path
    end 
  end

  def logout
    session[:assistant] = nil
    redirect_to assistants_loggin_path
  end

  def doctors
    if OfficeAssistant.exists?(session[:assistant])
    @assistant =  OfficeAssistant.find(session[:assistant])
    else
      session[:assistant] = nil 
      redirect_to assistants_loggin_path
    end
  end

  def doctor
    require 'will_paginate/array'
    @user = User.find(params[:id])
    @permissioning = assistant_permissioning(@user)

    session[:viweruser] = @user.id
    @user_signs = VitalSign.where(:owner_by => @user.id).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @diagnostics = Diagnostic.where(:owner_by => @user.id).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @single_file = SingleFile.where(:creator_id => @user.id).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @typer = params[:typex]
  end
  
  def edit_doctor
    @user = User.find(params[:id])
    session[:viweruser] = @user.id
  end

  def cites
    require 'will_paginate/array'
    @user = viewver_user
    if @user == nil
      @user = User.find(params[:id])
      session[:viweruser] = @user.id
    end
    @personal_cites = @user.doctor_cites
    @other_cites = @user.cite_doctors
    @tasks =  @other_cites + @personal_cites
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @notices = @user.my_request_from_notice.last(15)
  end

  def messages
  end
  
  def new
  end

  def assistant_permissioning(user)
    assistant = OfficeAssistant.find(session[:assistant])
    assistant =  assistant.office_assistant_assigned_doctors.where(user_id: user.id)
    assistant.map { |x| x.assistant_permissioning}
  end

  def find_user_to_action
    @user = User.find(params[:user_id])
    if params[:type_id] == 'clinical_history'
      redirect_to clinical_history_path(user: @user.id)
    end
  end

  def edit_assistant
    @assitant = OfficeAssistant.find(session[:assistant])
  end

  def update_assistant
     @assitant = OfficeAssistant.find(session[:assistant])
     if params[:name] != nil
     @assitant.name = params[:name]
     end
     if params[:phone]  != nil
     @assitant.phone = params[:phone]
     end
     if params[:email] != nil
     @assitant.email = params[:email]
     end
     @assitant.save

     flash[:notice] = "Actualización de asistente completada"
     redirect_to assistans_doctor_path
  end

  def assistents
   @assistents = current_user.office_assistants
  end

  def patients
    @user = User.find(params[:user])
    @user_patients = @user.patients.paginate(:page => params[:page], :per_page => 30)
  end

  def add_assistant_by_doctor
    assistant =  OfficeAssistant.find_by_email(params[:email])
    if assistant == nil
      assistant = OfficeAssistant.create(email: params[:email], name: params[:name], password: params[:password], phone: params[:phone])
      assistant_to_doctor = OfficeAssistantAssignedDoctor.create(user_id: current_user.id, office_assistant_id: assistant.id )
      flash[:notice] = 'Se ha agregado el asistente médico'
      redirect_to assistents_path
    else
      assistant_to_doctor_find =  OfficeAssistantAssignedDoctor.find_by_user_id_and_office_assistant_id(current_user.id, assistant.id )
      if assistant_to_doctor_find == nil
      assistant_to_doctor = OfficeAssistantAssignedDoctor.create(user_id: current_user.id, office_assistant_id: assistant.id )
      flash[:notice] = 'Se ha agregado el asistente médico'
      redirect_to assistents_path
      else
      flash[:notice] = 'Este usuario ya es tu asistente.'
      redirect_to assistents_path 
      end
    end
  end

  def add_doctor_to_assistant
    assistant =  OfficeAssistant.find(session[:assistant])
    @user = User.find_by_email(params[:email])
    if @user != nil
      puts @user.id
      assistant_to_doctor_find =  OfficeAssistantAssignedDoctor.find_by_user_id_and_office_assistant_id(@user.id, assistant.id )
      if assistant_to_doctor_find == nil
        assistant_to_doctor = OfficeAssistantAssignedDoctor.create(user_id: @user.id, office_assistant_id: assistant.id )
        flash[:notice] = 'Se ha agregado el asistente médico'
        redirect_to assistans_doctor_path
      else
        flash[:notice] = 'Este usuario ya es tu asistente.'
        redirect_to assistans_doctor_path 
      end
    else
       flash[:notice] = 'El usuario que intenta agregar no existe.'
       redirect_to assistans_doctor_path 
    end
  end

  def remove_doctor
    @office_assistant =  OfficeAssistantAssignedDoctor.find_by_user_id_and_office_assistant_id(params[:user_id], session[:assistant])
    @office_assistant.destroy
    flash[:notice] ="Se ha eliminado el Médico"
    redirect_to :back
  end

  def remove_assistant
    @office_assistant = OfficeAssistant.find(params[:assistant])
    if @office_assistant.users.count == 1
      @office_assistant.destroy
      else
      @assitant_relate = OfficeAssistantAssignedDoctor.find_by_user_id_and_office_assistant_id(current_user.id, params[:assistant] )
      @assitant_relate.destroy
    end
    flash[:notice] ="Se ha eliminado el asistente"
    redirect_to :back
  end

  def create_session
    assistant =  OfficeAssistant.find_by_email(params[:email])
    password = validate_password(params[:password], assistant.password)
    if password
      session[:assistant] = assistant.id
      flash[:notice] = "Bienvenido"
      redirect_to assistans_doctor_path
    else
      flash[:notice] = "Su usuario o contraseña son incorrectos"
      redirect_to assistants_loggin_path
    end
  end


private

  def validate_password(password, comparepass)
     sha256 = Digest::SHA256.new
     password = sha256.update password
     if password == comparepass
      @compare = true
      else
      @compare = false
     end
     puts ">>>>>>>#{@compare}<<<<<<<"
     @compare
  end

  def loggin_filter_in_assitant
    if session[:assistant] == nil
      redirect_to assistants_loggin_path
    end
  end

end
