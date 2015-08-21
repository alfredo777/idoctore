class DentalRecordsController < ApplicationController
  before_action :set_dental_record, only: [:show, :edit, :update, :destroy]
  before_filter :loggin_filter

  # GET /dental_records
  # GET /dental_records.json
  def index
    @user = User.find(params[:id])
    @dental_records = @user.dental_records.paginate(:page => params[:page], :per_page => 30)
    if validate_accepted_patient(current_user, @user) == false
    flash[:notice] = "No puedes ingresar al paciente porque no es tu paciente"
    redirect_to :back
    end
  end

  # GET /dental_records/1
  # GET /dental_records/1.json
  def show
     @dental_record = DentalRecord.find(params[:id])
     @user = @dental_record.user
    if validate_accepted_patient(current_user, @user) == false
    flash[:notice] = "No puedes ingresar al paciente porque no es tu paciente"
    redirect_to :back
    end
  end

  # GET /dental_records/new
  def new
    @dental_record = DentalRecord.new
    @user = User.find(params[:id])

    if validate_accepted_patient(current_user, @user) == false && @user.id != current_user.id
    flash[:notice] = "No puedes ingresar al paciente porque no es tu paciente"
    redirect_to :back
    end

  end

  # GET /dental_records/1/edit
  def edit
  end

  # POST /dental_records
  # POST /dental_records.json
  def create
    @dental_record = DentalRecord.new(dental_record_params)
    puts @dental_record
    puts params[:user_id]
    respond_to do |format|
      if @dental_record.save
        format.html { redirect_to @dental_record, notice: 'Dental record was successfully created.' }
        format.json { render :show, status: :created, location: @dental_record }
      else
        format.html { render :new }
        format.json { render json: @dental_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dental_records/1
  # PATCH/PUT /dental_records/1.json
  def update
    respond_to do |format|
      if @dental_record.update(dental_record_params)
        format.html { redirect_to @dental_record, notice: 'Dental record was successfully updated.' }
        format.json { render :show, status: :ok, location: @dental_record }
      else
        format.html { render :edit }
        format.json { render json: @dental_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dental_records/1
  # DELETE /dental_records/1.json
  def destroy
    @dental_record.destroy
    respond_to do |format|
      format.html { redirect_to dental_records_url, notice: 'Dental record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dental_record
      @dental_record = DentalRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dental_record_params
      params.require(:dental_record).permit(:user_id, :clinical_history_id, :doctor_id, :note, tooths_attributes: [:number, :top, :bottom, :left, :right, :center, :problem, :note])
    end
end
