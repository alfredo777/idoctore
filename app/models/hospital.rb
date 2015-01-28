class Hospital < ActiveRecord::Base
	has_many :user_hospitals
	has_many :users, through: :user_hospitals
    validates_uniqueness_of :secure_code
	after_create do 
		self.salt = SecureRandom.hex(7)
		self.secure_code = SecureRandom.hex(5)
		password = self.password
		encripted = Digest::SHA2.hexdigest(password)
		if self.password != encripted
               self.password = encripted
               self.save
        end
	end
	def encripted_codification
      Digest::SHA2.hexdigest( self.salt + self.password.to_s + secure_key ) 
    end

	def w_digest(passtd)
     cript = Digest::SHA2.hexdigest( self.salt + passtd.to_s + secure_key )
     compare_acces(cript, encripted_codification )
    end

    def secure_key
     "ropopaodijroier094019091240i1jfnejfn2h2hr02ih02hfiu2bn32inr02inf0nf20323nf20n2f03nf2nf2n0f203nf20n3023u"
    end
    
    
  def compare_acces(cript, decript)
    if cript ==  decript
        true
      else
        false
    end
  end



end
