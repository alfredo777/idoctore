class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :loggin_filter, only: [:index, :show, :edit]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show   
   @user_vital_signs = @user.vital_signs.last(5)
   @user_diagnostics = @user.diagnostics.last(5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    #puts "password a #{@user.password_confirmation} b #{@user.password}" 

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

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
            flash[:notice] = 'Se ha creado correctamente el usuario, se le ha mandado un email con las instrucciones de confirmación.'
            redirect_to users_path
            else
            flash[:notice] = 'Hemos tenido un error al crear el usuario.'
            redirect_to :back

          end
         else
           flash[:notice] = 'No se ha podido agregar el usuario debido a que la validación de password no coincide.'
           redirect_to :back
         end
       else
          flash[:notice] = 'No se puede crear el usuario si no acepta los términos y condiciones del sitio.'
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
 
              flash[:notice] = 'Se ha enviando una solicitud de doctor paciente al usuario'
            else
              flash[:notice] = 'La relación doctor paciente ya existe'

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
              flash[:notice] = 'Se ha agregado satisfactoriamente el miembro de la red.'
              else
              flash[:notice] = 'El usuario no ha podido ser creado.'
          end
      end
  end

  def existent_user_recive_invitation
     @invity_by = User.find(params[:secret_key])
     @user.confirmed_token = nil
     @user.save
     flash[:notice] = 'Has agregado al Doctor a tu lista de doctores.'
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
           format.html { redirect_to @user, notice: 'Sessión Creada' }
        end
       else
        respond_to do |format|
           format.html { redirect_to users_path, notice: 'Sessión ya está en curso' }
        end
      end
      else
        flash[:notice] = 'No se han aceptado los términos y condiciones del sitio.'
        redirect_to root_path 
    end
  end

  def destroy_session
     @s = Session.find_by_user_id(params[:id])
     @s.destroy
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
    flash[:notice] = 'Se ha agregado satisfactoriamente el miembro de la red.'
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

        flash[:notice] = 'Se ha agregado satisfactoriamente el miembro de la red.'
        
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
    flash[:notice] = 'Se ha enviado un mail con las instrucciones para el cambio de constraseña.'
    redirect_to root_path
  end

  def change_password
        @user = User.find(params[:id])
        @user.hashed_password = "#{params[:password]}"
        @user.save
        if @user.save
              flash[:notice] = 'Se ha guardado correctamente tu contraseña porfavor inicia sesión en ingresar.'
              redirect_to sign_in_path
           else
            flash[:notice] = 'No se ha guardado correctamente la contraseña.'
            redirect_to :back
        end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :hashed_password, :salt, :email, :register, :confirmed_token, :confirmed)
    end   
end
