class InstitutionsController < ApplicationController
  before_filter :institutions_filter
  def create
    @institutions = Institution.create(logo_string: params[:file], user_id: current_user.id, name: params[:name], study_or_do: params[:study_or_do], appears_in_diagnostic: params[:appears_in_diagnostic], recipe_appears: params[:recipe_appears] )
    flash[:notice] = 'Se ha creado correctamete tu institución'
    redirect_to :back
  end

  def update
  end

  def delete
    @institution = Institution.find(params[:delete_act])
    @institution.destroy
    flash[:notice] = 'Institutción Eliminada'
    redirect_to :back
  end

  def new
    @institutions = current_user.institutions
  end
  
  private
  def institutions_filter
    if current_user.role == 'patient'
      redirect_to user_path(current_user.id)
    end
  end
end
