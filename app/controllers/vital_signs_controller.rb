class VitalSignsController < ApplicationController
  before_filter :conf_session 

  def vital_signs_x
    @user = User.find(params[:id])
    @user_vital_signs = @user.vital_signs.paginate(:page => params[:page], :per_page => 10)
    layout_cahnge
  end
  def create_from_user
    @vital_sign = VitalSign.create(weight: params[:weight] , blood_pressure_up: params[:blood_pressure_up] , blood_pressure_down: params[:blood_pressure_down] , pulse: params[:pulse] , height: params[:height]  , breathing: params[:breathing], temperature: params[:temperature] , user_id: params[:user_id], owner_by: params[:owner_by] )
    flash[:notice] = "Se han agregado los signos vitales correctamente"
    redirect_to :back
  end

  def destroy
    @vital_sign.destroy
    respond_to do |format|
      format.html { redirect_to vital_signs_url }
      format.json { head :no_content }
    end
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
