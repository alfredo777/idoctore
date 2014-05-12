class UserMailer < ActionMailer::Base
  default from: "DoctorMind@contact.com"

   def welcome_email(user, confirmes)
    @user = user
    @url = confirmes
    mail(to: @user.email, subject: 'Bienvenido a Doctor Mind te invitamos a que confirmes tu cuenta para poder acceder ')
   end

   def invite_user_email(sender ,user, confirmes)
    @user = user
    @invite_from = sender
    @url = confirmes
    mail(to: @user.email, subject: "Has sido invitado a Doctor Mind")
   end

   def missing_password(user, confirmes)
     @user = user
     @url = confirmes
     mail(to: @user.email, subject: "Has solicitado recuperar contraseña a Doctor Mind.")
   end
end
