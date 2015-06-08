class SingleFilesController < ApplicationController
  before_filter :conf_session 
  
  def single_files_x
    @user = User.find(params[:id])
    @single_files = @user.single_files.paginate(:page => params[:page], :per_page => 10)
    layout_cahnge
  end
  def upload_file

    if !params[:file].nil?
      @file_upload =  SingleFile.create(:archive => params[:file], :user_id => params[:user_id], :creator_id => params[:creator_id])
      flash[:notice] = "Archivo agregado correctamete."
    else
      flash[:notice] = "Archivo vacio es imposible guardar."
    end
    redirect_to :back

  end

  def delete
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
