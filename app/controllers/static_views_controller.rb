class StaticViewsController < ApplicationController
  layout 'layout_not_login', except: [:contact]
  def home
    if session_status
      redirect_to users_path
    else
      if session[:admin] != nil
        redirect_to admin_path
      else
        @title_page = 'Bienvenido a DM'
        @content = 'Preparate a vivir una nueva experiencia de manejo de recursos médicos, esta plataforma esta enfocada 100% al uso y manejo de correcto de expedientes clínicos, usted puede ingresar como médico o como paciente y revisar su historial las 24 horas del día.'
      end
    end
  end

  def prices
    @validate = Geocoder.search("#{session[:lat]},#{session[:long]}")
    puts @validate
  end

  def create_location
    session[:lat] = params[:latitude]
    session[:long] = params[:longitude]
  end

  def register
  end

  def about_us
  end

  def what_work
  end

  def contact
      render layout: 'contact'

  end

  def send_contact
   if params[:mail].nil? | params[:name].nil? | params[:description].nil?
       flash[:notice] = "Tienes que llenar todos los campos para que el envio sea exitoso"
        redirect_to :back
   else
   @m =  UserMailer.contact_to_admin(params[:mail], params[:name], params[:description]).deliver
   flash[:notice] = "Se ha enviado correctamten tu email"
   redirect_to root_path
   end
  end

  def post
    @user = User.find(params[:id])
    @type = params[:type]
    respond_to do |f|
      f.js
    end
  end

  def visualizer
    case params[:type]
    when 'signs'
      @find = VitalSign.find(params[:id])
    when 'diacnostic'
      @find = Diagnostic.find(params[:id])
    when 'analisis'
      @find = SingleFile.find(params[:id])
    end

    @type = params[:type]

    respond_to do |f|
      f.js
    end
  end
end
