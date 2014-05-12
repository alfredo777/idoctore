class VitalSignsController < ApplicationController
  def create_from_user
    @vital_sign = VitalSign.create(weight: params[:weight] , blood_pressure_up: params[:blood_pressure_up] , blood_pressure_down: params[:blood_pressure_down] , pulse: params[:pulse] , height: params[:height]  , breathing: params[:breathing], temperature: params[:temperature] , user_id: params[:user_id], owner_by: params[:owner_by] )
    redirect_to :back
  end

  def destroy
    @vital_sign.destroy
    respond_to do |format|
      format.html { redirect_to vital_signs_url }
      format.json { head :no_content }
    end
  end

end
