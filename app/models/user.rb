class User < ActiveRecord::Base
   has_one  :session
   has_many :vital_signs
   has_many :diagnostics
   has_many :notes
   has_many :cite_doctors

   ##### validamos por email #####
   
   validates_uniqueness_of :email
   validates_presence_of :email
   #validates_format_of   :email, :with => /^[\-a-z0-9]+$/

   mount_uploader :avatar, AvatarUploader

   after_create do 
       self.register = Time.now
       self.last_loggin = Time.now
       self.salt = generate_salt
       self.save
       puts "creando el usuario #{email}"

   end

  def generate_salt
       o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
       string = (0...50).map { o[rand(o.length)] }.join
       salt = string
  end 

    
  def password
        password = self.hashed_password
		if password.present?
		 self.encrypt_password(password, self.salt)
		end 
  end

  def encrypt_password(password, salt) 
   	Digest::SHA2.hexdigest(password + "localemsimpledrifle" + salt)
  end

  def patients
    id_patients = []
    @dp = DoctorPatient.where(doctor_id: self.id)
    @dp.each do |idp|
      id_patients.push(idp.patient_id)
    end
    @users = User.find(id_patients)
  end
 
  def doctors
    id_patients = []
    @dp = DoctorPatient.where(patient_id: self.id)
    @dp.each do |idp|
      id_patients.push(idp.patient_id)
    end
    @users = User.find(id_patients)
  end

  def create_adanced_key
    if self.advanced_key == nil
       o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
       string = (0...110).map { o[rand(o.length)] }.join
       self.advanced_key = string 
       self.save
    end
  end

  def ageu
    if self.birthday != nil
    @age = (Date.today.to_time - self.birthday.to_time)/1.year 
    "#{@age.round(2)} años"
    else
    "Actualiza tu fecha de nacimiento"
    end
  end

  def doctor_cites
   @cites =  CiteDoctor.where(:doctor_id =>  self.id)
  end
  
end
