class StaticViewsController < ApplicationController
  layout 'layout_not_login'
  def home
    if session_status
      redirect_to users_path 
     else
  	@title_page = 'Bienvenido a DM'
  	@content = 'Preparate a vivir una nueva experiencia de manejo de recursos médicos, esta plataforma esta enfocada 100% al uso y manejo de correcto de expedientes clínicos, usted puede ingresar como médico o como paciente y revisar su historial las 24 horas del día.'
    end
  end

  def prices
  end

  def register
  end

  def about_us
  end
end
