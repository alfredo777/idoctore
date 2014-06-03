class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :loggin_filter, only: [:index, :show, :edit]
  before_filter :filter_to_update, only: [:edit, :actualize]
  before_filter :filter_view_pofile, only: [:show, :diagnostics]
  # GET /users
  # GET /users.json

  ######### vistas de consulta ########
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show   
   @user = User.find(params[:id])
   @user_vital_signs = @user.vital_signs.last(5)
   @user_diagnostics = @user.diagnostics.last(5)
   @personal_cites = @user.doctor_cites
   @other_cites = @user.cite_doctors
   @tasks =  @other_cites + @personal_cites
   @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def diagnostics
    @user=User.find(params[:id])
    @diagnostics = @user.diagnostics.paginate(:page => params[:page], :per_page => 10)
    
    respond_to do |format|
      format.html
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def actualize
    @user = User.find(params[:id])
    if params[:email] != nil
      @user.email = params[:email]
    end

    if params[:name] != nil
      @user.name = params[:name]
    end

    if params[:birthday] != nil
      @user.birthday = params[:birthday]
    end

    if params[:password] != nil
        if params[:password] == params[:confirm_password]
          @user.hashed_password = params[:password]
        end
    end
    
    if params[:file] != nil
       @user.avatar = params[:file]   
    end

    @user.save
    flash[:notice] = 'Se ha actualizado el usuario.'
    redirect_to user_path(@user.id)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  ####### validaciones de creación registro y ejecución #########

  def register
      pass_a = "#{params[:password]}"
      pass_b = "#{params[:confirm_password]}"
      if params[:terms] != nil 
        if pass_a == pass_b
         @user = User.new
         @user.name = params[:name]
         @user.email = params[:email]
         @user.hashed_password = params[:password]
         @user.sex = params[:sex]
         @user.role = "#{params[:role]}"
         @user.confirmed_token = random_to_token
         @user.confirmed = false
         @user.terms = params[:terms]
         @user.save
          if @user.save 
            @mailer = UserMailer.welcome_email(@user, @user.confirmed_token).deliver
            flash[:notice] =  t('user.create_user')
            redirect_to users_path
            else
            flash[:notice] = t('user.user_simple_error')
            redirect_to :back

          end
         else
           flash[:notice] = t('user.user_password_error')
           redirect_to :back
         end
       else
          flash[:notice] = t('user.user_non_terms_error')
          redirect_to :back
      end
  end

  def create_user_by_invite
       ###### add new user to plataform ####
       @u = User.find_by_email(params[:email])
       if @u != nil
           @dp_find = DoctorPatient.where(:doctor_id => current_user.id, :patient_id => @u.id)  

           if @dp != nil
              @dp = DoctorPatient.create(:doctor_id => current_user.id, :patient_id => @user_new.id)  
               @mailer = UserMailer.invite_user_email(current_user ,@user_new, @user_new.confirmed_token).deliver
 
              flash[:notice] = t('user.solicitud_user_by_invite')
            else
              flash[:notice] = t('user.error_solicitude_user_by_invite')

           end
       else
           @user_new = User.new
           @user_new.name = params[:name]
           @user_new.email = params[:email]
           @user_new.sex = params[:sex]
           @user_new.hashed_password = rand(2000..3000)
           @user_new.role = "patient"
           @user_new.confirmed_token = random_to_token
           @user_new.confirmed = false
           @user_new.save
              ###### add patient to user interface ##### 
               @dp = DoctorPatient.create(:doctor_id => current_user.id, :patient_id => @user_new.id)   
          if @user.save 
              @mailer = UserMailer.invite_user_email(current_user ,@user_new, @user_new.confirmed_token).deliver
              redirect_to patients_path(current_user.id)
              flash[:notice] = t('user.create_user_by_invite')
              else
              flash[:notice] = t('user.error_create_user_by_invite')
          end
      end
  end

  def existent_user_recive_invitation
     @invity_by = User.find(params[:secret_key])
     @user.confirmed_token = nil
     @user.save
     flash[:notice] = t('user.existe_user_invite_accepted')
     redirect_to user_path(@user)
  end

  def create_session
    @user = User.find_by_email(params[:email])
    if @user.terms == true
      if @user.session == nil
      session[:user] = @user.id
      @time_expire = Time.now + 6.hours
      @session = Session.create(:user_id => @user.id, :caduce => @time_expire)
        respond_to do |format|
           format.html { redirect_to @user, notice: t('user.create_session') }
        end
       else
        respond_to do |format|
           session[:user] = @user.id
           format.html { redirect_to @user, notice: t('user.session_in_course') }
        end
      end
      else
        flash[:notice] = t('user.non_terms_accepted')
        redirect_to root_path 
    end
  end

  def destroy_session
     @s = Session.find_by_user_id(params[:id])
     if @s != nil
     @s.destroy
     end
     session[:user] = nil
     redirect_to root_path
  end

  def session_new

  end

  def confirmed_token
    @user = User.find_by_confirmed_token(params[:confirmed_token])
    puts "#{@user}"
    @user.confirmed_token = nil
    @user.confirmed = true
    @user.save
    flash[:notice] = t('user.confirmed_token')
      if @user != nil
           redirect_to sign_in_path
      else
           redirect_to root_path
      end
  end

  def reset_password
        @user = User.find_by_confirmed_token(params[:confirmed_token])
        puts "#{@user}"
        @user.confirmed_token = nil
        @user.confirmed = true
        @user.save
      
          @dp = DoctorPatient.find_by_patient_id(@user.id)   
          if @dp != nil
            @dp.accepted_request = true
            @dp.save
          end

        flash[:notice] = t('user.reset_password')
        
        respond_to do |format|
          format.html
        end
  end

  def missing_password

  end

  def change_missing_password
    @user = User.find_by_email(params[:email])
    @user.confirmed_token = random_to_token
    @user.save
    @mailer = UserMailer.missing_password(@user, @user.confirmed_token).deliver
    flash[:notice] = t('user.mail_to_change_password')
    redirect_to root_path
  end

  def change_password
        @user = User.find(params[:id])
        @user.hashed_password = "#{params[:password]}"
        @user.save
        if @user.save
              flash[:notice] = t('user.satify_change_password')
              redirect_to sign_in_path
           else
            flash[:notice] =  t('user.password_non_safe')
            redirect_to :back
        end
  end
  
  #### crear cita

  def send_request_cite
    #CiteDoctor.create

    date =  params[:init_time_date] + ' ' +params[:init_time_hour]

      case  current_user.role 
        when 'doctor'
        ###### cite auto confirmed #####
        @cite = CiteDoctor.create( init_time: date, request: params[:request], confirmed_by_doctor: true, user_id: params[:user_id], doctor_id: params[:doctor_id])
           date2 = @cite.init_time + 50.minutes
           @cite.finish_time = date2
        @cite.save
         when 'patient'
        ###### cite not confirmed solicite by other #######
        @cite = CiteDoctor.create( init_time: date, request: params[:request], confirmed_by_doctor: false, user_id: current_user.id, doctor_id: params[:doctor_id])
          date2 = @cite.init_time + 50.minutes
          @cite.finish_time = date2
        @cite.save
      end

      
      if @cite.save  
        flash[:notice] = 'Se a solicitado la cita correctamente.'
        redirect_to :back
      end

  end

  def responce_cite
  end

  def options_change_cite
     @cite = CiteDoctor.find(params[:ident_i])
     @type = params[:type]
    respond_to do |format|
      format.js
    end
  end

  def update_cites
    @cite = CiteDoctor.find(params[:id])
    date =  params[:init_time_date] + ' ' +params[:init_time_hour]
    @cite.init_time = date
    date2 = @cite.init_time + 50.minutes
    @cite.finish_time = date2
    @cite.save

    if @cite.save
        flash[:notice] = 'Se a actualizado la cita correctamente.'
        redirect_to :back
    else
        flash[:notice] = 'Cambios no actualizados.'
        redirect_to :back
    end

  end

  #### crear notificaciones

  def create_notice_cite
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def filter_to_update
      @user = User.find(params[:id])
      if @user.id ==  current_user.id
       # flash[:notice] = 'Bienbenido al editor de usuario.'
       else
        flash[:notice] = 'Usted no esta autorizado para editar este usuario.'
        redirect_to user_path(@user.id)
      end
    end
    
    def filter_view_pofile
      @user = User.find(params[:id])
      if current_user.id == @user.id
      else
         if validate_accepted_patient(current_user, @user)
          flash[:notice] = "Bienbenido al perfíl de tu paciente #{@user.name}"
         else
          flash[:notice] = 'El  usuario al que intentabas ingresar no es tu paciente.'
          redirect_to user_path(current_user.id)
         end

      end 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def user_params
    #  params.require(:user).permit(:name, :hashed_password, :salt, :email, :register, :confirmed_token, :confirmed, :)
    #end   
end
