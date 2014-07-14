class SingleFilesController < ApplicationController

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
