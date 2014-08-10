class ManagerUser < ActiveRecord::Base
   validates_uniqueness_of :email
   validates_presence_of :email
   validates_presence_of :password
   validates_uniqueness_of :identify

   after_create do 
       self.salt = generate_salt
       password = self.password
       encripted = Digest::SHA2.hexdigest(password)
       #identify_encripted = Digest::SHA2.hexdigest(self.identify)
        if self.password != encripted
               self.password = encripted
               #self.identify = identify_encripted
               self.save
        end
       puts "creando el usuario #{email}"
   end

   def generate_salt
	   rand(235..1234)
   end 

   def codificate_encripter
      Digest::SHA2.hexdigest( self.salt + self.password.to_s + self.identify.to_s ) 
   end

   def reciber_params_loggin(pass, ident)
      puts pass
      puts ident
      if pass == nil || ident == nil
         cript = Digest::SHA2.hexdigest( self.salt + pass.to_s + ident.to_s ) 
         validates_acces(cript, codificate_encripter )
        else
          valx = false
      end
   end

   def validates_acces(enc, paramx)
   	 if enc == paramx
   	 	 valx = true
   	 	else
   	 		valx =false
   	 end
   	  valx
   end




end
