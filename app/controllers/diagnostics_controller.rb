class DiagnosticsController < ApplicationController

  def create_from_user
    @diagnistic = Diagnostic.create(user_id: params[:user_id], interrogation: params[:interrogation], physical_examination: params[:physical_examination], diagnostic_or_clinical_problem: params[:diagnostic_or_clinical_problem], list_of_laboratory_studies: params[:list_of_laboratory_studies], required_therapies: params[:required_therapies], suggested_treatments: params[:suggested_treatments], owner_by: params[:owner_by], chronic: params[:chronic], outstanding: params[:outstanding], serious: params[:serious], inconsequential: params[:inconsequential], vital_signs: params[:vital_signs])
    if @diagnistic.save
      flash[:notice] = 'Se ha creado correctamente el diagnóstico'
      redirect_to :back
    else
      flash[:notice] = 'El diagnóstico no pudo ser creado'
      redirect_to :back
    end
  end

  def add_note
    @note = Note.create(content: params[:content], last_analysis: params[:last_analysis], last_signs: params[:last_signs] , new_treatment: params[:new_treatment], diagnostic_id: params[:diagnostic_id], user_id: params[:user_id])
    if @note.save
    redirect_to :back
    flash[:notice] = 'Se ha agregado la nota al axpediente'
    else
    redirect_to :back
    flash[:notice] = 'No se pudo crear la nota'
    end
  end
end



