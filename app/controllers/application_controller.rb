class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :session_status
  helper_method :validate_accepted_patient
  helper_method :status_if_request_patient_doctor_exist
  helper_method :random_to_token
  helper_method :find_advance_key
  helper_method :expires_now
  helper_method :decripted_code
  helper_method :undecript_code
  helper_method :action_host
  helper_method :changer_br
  before_filter :agent
  helper_method :agent
  helper_method :current_patients_p
  helper_method :viewver_user
  helper_method :current_assistant
  helper_method :thoots_list
  helper_method :thoots_list_child

  def current_user
    if  User.exists?(session[:user])
      @iuser = User.find(session[:user]) if session[:user] != nil
      else
      @iuser = viewver_user  
    end
  end

  def viewver_user
    if  User.exists?(session[:viweruser])
      @iuser = User.find(session[:viweruser]) if session[:viweruser] != nil
    end
  end

  def current_assistant
    if  OfficeAssistant.exists?(session[:assistant])
      @assistant =  OfficeAssistant.find(session[:assistant]) if session[:assistant] != nil
    end
  end

  def action_host
    case Rails.env
    when 'production'
      'http://idoctore.com/'
    when 'development'
      'http://localhost:3000'
    end
  end

  def current_patients_p
    @patients =  current_user.patients
  end

  def session_status
    if session[:user] == nil
      @status = false
    else
      @status = true
    end
  end

  def loggin_filter
    unless session_status
      redirect_to root_path
    end
  end

  def validate_accepted_patient(im, other)

    case current_user.role
    when'patient'
      @dp = DoctorPatient.find_by_doctor_id_and_patient_id(other.id,im.id)

    when 'doctor'
      @dp = DoctorPatient.find_by_doctor_id_and_patient_id(im.id,other.id)

    end

    if @dp != nil
      @dp.accepted_request
    else
      false
    end

  end

  def thoots_list
   { adult: [ :top => [18,17,16,15,14,13,12,11,21,22,23,24,25,26,27,28], :bottom => [48,47,46,45,44,43,42,41,31,32,33,34,35,36,37,38]]}
  end

  def thoots_list_child
    { child: [ top: [55,54,53,52,51,61,62,63,64,65], bottom: [85,84,83,82,81,71,72,73,74,75]]}
  end

  def status_if_request_patient_doctor_exist(im, other)
    case current_user.role
    when'patient'
      @dp = DoctorPatient.find_by_doctor_id_and_patient_id(other.id,im.id)

      if @dp != nil
        @n = '<a href="/local_confirm_relation?doctor='+"#{other.id}"+'"><span class="label">Aceptar solicitud</span></a>'
      else
        @n = "<a data-reveal-id="+"modal_#{other.id}"+"><span class=' patient_#{other.id} secondary label '"+"id=#{other.id}"+">No hay solicitud (Add) </span></a>"
      end

    when 'doctor'
      @dp = DoctorPatient.find_by_doctor_id_and_patient_id(im.id,other.id)
      if @dp != nil
        @n = '<span class="label"> Solicitud enviada </span>'
      else
        @n = "<a data-reveal-id="+"modal_#{other.id}"+"><span class=' patient_#{other.id} secondary label '"+"id=#{other.id}"+">No hay solicitud (Add) </span></a>"
      end
    end
  end

  def random_to_token
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    rand = (0...50).map { o[rand(o.length)] }.join
    string = rand
  end

  def find_advance_key(id)
    @user = User.find(id)
    @user.create_adanced_key
    @user.advanced_key
  end

  def changer_br(string)
    ax = string.gsub(',', '</br>  &#3903;')
    '<div stlye="text-align: left !important; width:100%;">'+'&#3903;'+ax + '</div>'
  end
  def agent
    result  = request.env['HTTP_USER_AGENT']
    puts result
      if result =~ /iPhone|Android|iPad/
        @browser = "Mobile"
        @mobile = true
      else
      case 
      when result =~ /Chrome/
        @browser = "Google Chrome"
        @mobile = false
      when result =~ /Firefox/
        @browser = "Firefox"
        @mobile = false
      when result =~ /Safari/
        @browser = "Safari"
        @mobile = false
      when result =~ /MSIE/
        @browser = "Internet Explorer"
        @mobile = false        
      end 
      end
    puts "********************** #{@browser} / Mobile: #{@mobile} ************************" 
       @mobile
    end
   
  private

  def decripted_code(codex = '', decript = 11)
    a = ('a'..'z').to_a
    x = codex.to_s.split(//)
    y = a.count-decript.to_i
    fa = a.last(y) + a.first(decript.to_i)
    fax = fa[0..9]
    act_array = []
    x.each do |xc|
      case xc.to_i
      when 0
        act_array.push(fax[0])
      when 1
        act_array.push(fax[1])
      when 2
        act_array.push(fax[2])
      when 3
        act_array.push(fax[3])
      when 4
        act_array.push(fax[4])
      when 5
        act_array.push(fax[5])
      when 6
        act_array.push(fax[6])
      when 7
        act_array.push(fax[7])
      when 8
        act_array.push(fax[8])
      when 9
        act_array.push(fax[9])
      end
    end
    xcv = act_array.map(&:inspect).join(' ')
    xcvb = xcv.remove('"')
    xcvbn = xcvb.remove(' ')
    xcvbn.to_s
  end

  def undecript_code(codex = '', decript = 11)
    a = ('a'..'z').to_a
    x = codex.to_s.split(//)
    y = a.count-decript.to_i
    fa = a.last(y) + a.first(decript.to_i)
    fax = fa[0..9]
    act_array = []
    x.each do |xc|
      case xc
      when fax[0]
        act_array.push(0)
      when fax[1]
        act_array.push(1)
      when fax[2]
        act_array.push(2)
      when fax[3]
        act_array.push(3)
      when fax[4]
        act_array.push(4)
      when fax[5]
        act_array.push(5)
      when fax[6]
        act_array.push(6)
      when fax[7]
        act_array.push(7)
      when fax[8]
        act_array.push(8)
      when fax[9]
        act_array.push(9)
      end
    end
    xcv = act_array.map(&:inspect).join(' ')
    xcvb = xcv.remove('"')
    xcvbn = xcvb.remove(' ')
    xcvbn.to_i
  end

end
