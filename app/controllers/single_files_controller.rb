class SingleFilesController < ApplicationController
  def single_files_x
    @user = User.find(params[:id])
    @single_files = @user.single_files.paginate(:page => params[:page], :per_page => 10)
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
end
