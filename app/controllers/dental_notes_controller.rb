class DentalNotesController < ApplicationController
  def create
    @create_dental_note = DentalNote.create(dental_record_id: params[:dental_record], note: params[:note], new_treatment: params[:new_treatment], doctor_id: params[:doctor_id])

    if @create_dental_note.save
      flash[:notice] = "La nota ha sido agregada correctamente"
      redirect_to :back
    else
      flash[:notice] = "La no nota ha sido agregada correctamente debido a que un campo es erroneo"
      redirect_to :back
    end
  end
end
