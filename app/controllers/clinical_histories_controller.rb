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
            if !fd.name.nil?
             history_familial_diseases.push(fd.name.downcase)
            end
           end
         end
       end

       @last4.each do |d|
         puts d.created_at
         if d.familial_diseases.count != 0
           d.phisical_explorations.each do |fd|
            if !fd.body_part.nil?
             history_phisical_explorations.push(fd.body_part.downcase)
            end
           end
         end
       end

       history_familial_diseases = history_familial_diseases.uniq
       history_phisical_explorations = history_phisical_explorations.uniq

       @updates = history_familial_diseases
       @anatomy_update = history_phisical_explorations
       @last1 = @user.clinical_histories.last

    end

    @vital_signs = @user.vital_signs

    dates_vital_signs = []
    weight = []
    blood_pressure_up = []
    blood_pressure_down = []
    temperature = []
    height = []

    @user.vital_signs.each do |vs|

      dates_vital_signs.push(vs.created_at.strftime("%m/%d/%y"))

      if !vs.weight.nil?
        weight.push(vs.weight)
      end
      if !vs.blood_pressure_up.nil?
        blood_pressure_up.push(vs.blood_pressure_up)
      end
      if !vs.blood_pressure_down.nil?
        blood_pressure_down.push(vs.blood_pressure_down)
      end
      if !vs.temperature.nil?
        temperature.push(vs.temperature)
      end
      if !vs.height.nil?
        height.push(vs.height)
      end
    end

    @dates_vital_signs = dates_vital_signs
    @weight = weight
    @blood_pressure_up = blood_pressure_up
    @blood_pressure_down = blood_pressure_down 
    @temperature = temperature
    @height = height

   

    layout_cahnge

  end

  def create
    @clinical_history = ClinicalHistory.create(clinical_history_params)

    if current_user.acupulture_clinical_history
      @acupunture = Acupuncture.find(session[:acupuncture])
      @acupunture.clinical_history_id = @clinical_history.id
      @acupunture.save
      session[:acupuncture] = nil

    end

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
    if current_user.acupulture_clinical_history
      session[:acupuncture] = nil
      rnd = SecureRandom.hex(23)
      session[:findidpoints] = rnd
    end

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
    params.require(:clinical_history).permit(:user_id, :suffering, :doctor_id ,:interview, :diagnostic_aux, :vital_sign_id ,:terapeutic_use, :diagnostic, :note_pathology, :note_no_pathology, :note_family, :habitus_exterior, :climatic_symptoms, :mental_symptoms, :sweting, :appetite, :thirst, :desires_food_or_food_refusal, :sleep, :sexuality, :skin_and_appendages, :musculoskeletal_apparatus, :endocrine_system, :hematopoietic_system, :digestive_system, :genitourinary_system, :nervous_system, :cardiovascular_system ,familial_diseases_attributes: [:name, :pathology, :genealogy], phisical_explorations_attributes: [:body_part, :notes], pathological_antecedents_attributes: [:name, :pathology], no_pathological_antecedents_attributes: [:name, :evaluation], vital_signs_attributes: [:user_id, :owner_by, :weight, :height, :blood_pressure_down, :blood_pressure_up, :pulse, :breathing, :temperature], dental_records_attributes: [:user_id, :note, :doctor_id, tooths_attributes: [:number, :top, :bottom, :left, :right, :center, :problem, :note, :class_action_top, :class_action_bottom, :class_action_left, :class_action_center, :class_action_right]])
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
