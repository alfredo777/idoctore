class ClinicalHistoriesController < ApplicationController
  before_filter :conf_session

  def view
    @user = User.find(params[:user])

    if @user.clinical_histories.count != 0

       history_familial_diseases = []
       history_phisical_explorations = []

       @last4 = @user.clinical_histories.last(7)
       
       @last4.each do |d|
         puts d.created_at
         if d.familial_diseases.count != 0
           d.familial_diseases.each do |fd|
             history_familial_diseases.push(fd.name.downcase)
           end
         end
       end

       @last4.each do |d|
         puts d.created_at
         if d.familial_diseases.count != 0
           d.phisical_explorations.each do |fd|
             history_phisical_explorations.push(fd.body_part.downcase)
           end
         end
       end

       history_familial_diseases = history_familial_diseases.uniq
       history_phisical_explorations = history_phisical_explorations.uniq

       @updates = history_familial_diseases
       @anatomy_update = history_phisical_explorations
       @last1 = @user.clinical_histories.last

    end
    layout_cahnge

  end

  def create
    @clinical_history = ClinicalHistory.create(clinical_history_params)

     if @clinical_history.save
        flash[:notice] = "Se ha creado correctamente la historia clínia"
        redirect_to clinical_history_path(user: @clinical_history.user_id)
        else
        flash[:notice] = "No se ha podido crear correctamente a la historia clínica debido a que hay campos vacios"
        redirect_to clinical_history_path(user: @clinical_history.user_id)
     end

  end

  def new
    @user = User.find(params[:user])
    c = @user.vital_signs.count 
    if c == 0
      @v = false
    else
      @v = @user.vital_signs.last
    end
    @clinical_history = ClinicalHistory.new
    layout_cahnge
  end

  def update
  end

  def edit
  end

  def index
  end

  def identification
    @user = User.find(params[:user])
    layout_cahnge
  end

  def open
    @clinical_history = ClinicalHistory.find(params[:history])
    @user = User.find(params[:user])
    layout_cahnge
  end


  def clinical_history_params
    params.require(:clinical_history).permit(:user_id, :suffering, :doctor_id ,:interview, :diagnostic_aux, :vital_sign_id ,:terapeutic_use, :diagnostic, familial_diseases_attributes: [:id, :name], phisical_explorations_attributes: [:body_part, :notes], pathological_antecedents_attributes: [:name, :note], no_pathological_antecedents_attributes: [:name, :note], vital_signs_attributes: [:user_id, :owner_by, :weight, :height, :blood_pressure_down, :blood_pressure_up, :pulse, :breathing, :temperature])
  end

  def layout_cahnge
    if session[:assistant] != nil
      render layout: "assistants"
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
end
