class ClinicalHistoriesController < ApplicationController
  def view
    @user = User.find(params[:user])
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
