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

   def notification_created_diagnostic(user)
     @user = user
     mail(to: @user.email, subject: "Se ha agregado un nuevo diagnóstico a tu expediente.")
   end

   def existent_user_invite(user, doctor)
     @user = user
     @doctor = doctor
     mail(to: @user.email, subject: "El doctor #{@doctor.name} ha indicado que eres su paciente.")
   end

   def contact_to_admin(email, name, description)
     @email = email
     @name = name
     @description = description
     mail(to: 'contacto@idoctore.com', subject: "La persona #{@name} se ha puesto en contacto contigo.")
   end
end
