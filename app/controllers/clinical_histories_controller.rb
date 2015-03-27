class ClinicalHistoriesController < ApplicationController
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


  end

  def create
    @clinical_history = ClinicalHistory.create(clinical_history_params)
     if @clinical_history.save
        flash[:notice] = "Se ha creado correctamente la historia clínia"
        redirect_to user_path(@clinical_history.user_id)
        else
        flash[:notice] = "No se ha podido crear correctamente a la historia clínica"
        redirect_to :back

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
  end

  def update
  end

  def edit
  end

  def index
  end

  def open
    @clinical_history = ClinicalHistory.find(params[:history])
  end


  def clinical_history_params
    params.require(:clinical_history).permit(:user_id, :suffering, :doctor_id ,:interview, :diagnostic_aux, :terapeutic_use, :diagnostic,familial_diseases_attributes: [:id, :name], phisical_explorations_attributes: [:body_part, :notes])
  end
end
