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


  def current_user
    if  User.exists?(session[:user])
      @iuser = User.find(session[:user]) if session[:user] != nil
    end
  end

  def action_host
    case Rails.env
    when 'production'
      'http://idoctore.herokuapp.com/'
    when 'development'
      'http://localhost:3000'
    end
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
