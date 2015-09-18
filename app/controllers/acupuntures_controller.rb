class AcupunturesController < ApplicationController
  before_filter :loggin_filter
  def create
    @acupuncture = Acupuncture.create(user_id: params[:user_id], doctor_id: params[:doctor_id], findid: params[:findid], note: params[:note])
    if @acupuncture.save
    flash[:notice] = "se ha creado correctamente el registro"
    acupunture_points = AcupunturePoint.where(findid: @acupuncture.findid)
    acupunture_points.each do |acp|
       acp.acupuncture_id = @acupuncture.id
       acp.save
       puts acp.acupuncture_id
    end
    
    if params[:remotex] == "true"
      session[:acupuncture] = @acupuncture.id
      respond_to do |format|
        format.js
      end
      else  
      redirect_to acupuntures_view_path(id: @acupuncture.id)
    end 

    else
    flash[:notice] = "El registro no ha podido ser creado por falta de usuario"
    redirect_to :back
    end
    
  end

  def index
    @user = User.find(params[:id])
    @acupunctures = @user.acupunctures.paginate(:page => params[:page], :per_page => 30).order('created_at DESC')
  end

  def view
    @acupuncture = Acupuncture.find(params[:id])
  end

  def new
    rnd = SecureRandom.hex(23)
    session[:findidpoints] = rnd
    if params[:id] ==  nil
    @user = current_user
    else
    @user = User.find(params[:id])
    end
  end

  def create_point
    @point = AcupunturePoint.create(x_axis: params[:x_axis], y_axis: params[:y_axis], name: params[:name], note: params[:note], findid: params[:findid])
    @id_to_close = "light-#{params[:divx]}"
    @id_to_close_2 = "#{params[:divx]}"
    if @point.save 
      @notice = "Se ha creado correctamente"
      @error = false
     else
      @notice = "El punto no pudo ser guardado"
      @error = true
    end

    respond_to do |format|
      format.js
    end

  end

  def generate_point
    @id = params[:id]
    @numerit = params[:id].to_i * rand(102...23232)
    @id_modify = 'point-'+ "#{@numerit}"
    @x_axis = params[:x_axis]
    @y_axis = params[:y_axis]

    respond_to do |format|
      format.js
    end
  end
end
