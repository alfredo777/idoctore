class ManagerUser < ActiveRecord::Base
   validates_uniqueness_of :email
   validates_presence_of :email
   validates_presence_of :password
   validates_uniqueness_of :identify

   after_create do 
       self.salt = generate_salt
       password = self.password
       encripted = Digest::SHA2.hexdigest(password)
       identify_encripted = Digest::SHA2.hexdigest(self.identify)
        if self.hashed_password != encripted
               self.hashed_password = encripted
               self.identify = identify_encripted
               self.save
        end
       puts "creando el usuario #{email}"
   end

   def generate_salt
	   rand(235..1234)
   end 

   def codificate_encripter
      Digest::SHA2.hexdigest( self.salt + self.hashed_password.to_s + self.identify ) 
   end

   def reiciber_params_loggin(pass, ident)
      cript = Digest::SHA2.hexdigest( self.salt + pass + ident ) 
      compare_acces(cript, codificate_encripter )
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
