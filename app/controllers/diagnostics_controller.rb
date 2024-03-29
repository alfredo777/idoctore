class DiagnosticsController < ApplicationController
  layout 'panel', only: [:create_d]

  def create_from_user
    @user = User.find(params[:user_id])
    @clinical_h =  @user.clinical_histories.last
    if @user.vital_signs.count != 0
      @vsx =  @user.vital_signs.last
      @vs = @vsx.id
    else
      @vs = nil
    end
    @diagnistic = Diagnostic.create(user_id: params[:user_id], interrogation: params[:interrogation], physical_examination: params[:physical_examination], diagnostic_or_clinical_problem: params[:diagnostic_or_clinical_problem], list_of_laboratory_studies: params[:list_of_laboratory_studies], required_therapies: params[:required_therapies], suggested_treatments: params[:suggested_treatments], owner_by: params[:owner_by], chronic: params[:chronic], outstanding: params[:outstanding], serious: params[:serious], inconsequential: params[:inconsequential], vital_signs: @vs )
    url = "#{action_host}/plain_show/#{@diagnistic.id}"
    @diagnistic.update_attribute :qrcode, url.to_s
    if @clinical_h != nil
      puts "#{@clinical_h.id}"
      if params[:add_clinical]
        if @clinical_h != nil
          @clinical_history_add = ClinicalHistoryToDiagnostic.create(diagnostic_id: @diagnistic.id, clinical_history_id: @clinical_h.id )
          puts "#{@clinical_history_add.id}"
        end
      end
    end
    if @diagnistic.save
      @mailer = UserMailer.notification_created_diagnostic(@user).deliver
      if @clinical_h != nil
      flash[:notice] = 'Se ha creado correctamente el diagnóstico'
      else
        if params[:add_clinical]
          flash[:notice] = 'Se ha guardado el diagnóstico pero no ha podido agregarse a la historía clinica ya que no hay ninguna vigente'
        else
          flash[:notice] = 'Se ha creado correctamente el diagnóstico'
        end
      end
      if viewver_user != nil
        redirect_to assistans_doctor_show_path(id: viewver_user.id)
      else
        redirect_to user_path(params[:user_id])
      end
    else
      flash[:notice] = 'El diagnóstico no pudo ser creado'
      if viewver_user != nil
        redirect_to assistans_doctor_show_path(id: viewver_user.id)
      else
        redirect_to user_path(params[:user_id])
      end
    end
  end

  def all_create
    require 'will_paginate/array'
    @user = current_user
    @user_signs = VitalSign.where(:owner_by => current_user.id).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @diagnostics = Diagnostic.where(:owner_by => current_user.id).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @single_file = SingleFile.where(:creator_id => current_user.id).paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
    @typer = params[:typex]
  end

  def add_note

    if "#{params[:add_to_diagnostic]}" == "true"  && "#{params[:add_clinical]}" == "true"
      @note = Note.create(content: params[:content], last_analysis: params[:last_analysis], last_signs: params[:last_signs] , new_treatment: params[:new_treatment], diagnostic_id: params[:diagnostic_id], user_id: params[:user_id], clinical_history_id: params[:clinical_history_id])
    end
    
    if "#{params[:add_to_diagnostic]}" == "true" 
      @note = Note.create(content: params[:content], last_analysis: params[:last_analysis], last_signs: params[:last_signs] , new_treatment: params[:new_treatment], diagnostic_id: params[:diagnostic_id], user_id: params[:user_id])
    end

    if "#{params[:add_clinical]}" == "true" 
     @note = Note.create(content: params[:content], last_analysis: params[:last_analysis], new_treatment: params[:new_treatment], clinical_history_id: params[:clinical_history_id], user_id: params[:user_id])
    end

    if @note.save
      redirect_to :back
      flash[:notice] = 'Se ha agregado la nota al axpediente'
    else
      redirect_to :back
      flash[:notice] = 'No se pudo crear la nota'
    end
  end

  def destroy
    @diagnostic = Diagnostic.find(params[:diagnostic])

    @compending = " User: #{@diagnostic.user_id} | Iterrogation: #{@diagnostic.interrogation} | physical_examination:  #{@diagnostic.physical_examination} |  diagnostic_or_clinical_problem: #{@diagnostic.diagnostic_or_clinical_problem} | list_of_laboratory_studies: #{@diagnostic.list_of_laboratory_studies} | required_therapies: #{@diagnostic.required_therapies} | suggested_treatments: #{@diagnostic.suggested_treatments} | created_at: #{@diagnostic.created_at} | owner_by: #{@diagnostic.owner_by}  | chronic: #{@diagnostic.chronic} | outstanding: #{@diagnostic.outstanding} |  serious: #{@diagnostic.serious} | inconsequential: #{@diagnostic.inconsequential} | vital_signs: #{@diagnostic.vital_signs}"
    @dh =  DeleteHistory.create(user_id: params[:user_id], owner_id: params[:owner_id], delete_content: @compending, causes: params[:causes], justify: params[:justify])
    @diagnostic.notes.destroy_all
    @diagnostic.destroy

    flash[:notice] = 'Se ha eliminado correctamente el diagnóstico.'
    redirect_to :back
  end

  def plain_show
    @diagnostic = Diagnostic.find(params[:id])
    respond_to do |f|
      f.html
    end
  end

  def qrcode_view
    @diagnostic = Diagnostic.find(params[:id])

    respond_to do |format|
      format.html
      format.png
    end
  end

  def printing_diagnostic
    @diagnostic = Diagnostic.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def printing_threatment
    @diagnostic = Diagnostic.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def cie10
    require 'csv'
    posible_results = []
    @url = Rails.root.join("public", "/data_bases/cie10.csv")
    puts @url
    @rescue = params[:rescue_name]
    puts "#{@rescue}"
    CSV.foreach("#{Rails.root}/public/data_bases/cie10.csv") do |csv|
      code = csv[0]
      descript = csv[1]
      dsc = descript.downcase.to_s
      ds = descript.to_s


      @include =  dsc.include? params[:rescue_name].to_s

      if @include
        posible_results.push([code,ds])
      end
    end

    puts "#{posible_results}"

    @results = posible_results

    respond_to do |format|
      format.js
    end
  end
end
