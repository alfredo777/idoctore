class User < ActiveRecord::Base
   has_one  :session
   has_many :vital_signs
   has_many :diagnostics
   has_many :notes
   has_many :cite_doctors
   has_many :single_files, dependent: :destroy
   has_many :notices, dependent: :destroy
   has_many :cupons, dependent: :destroy
   has_many :institutions, dependent: :destroy
   has_many :payments, dependent: :destroy
   has_many :user_hospitals
   has_many :hospitals, through: :user_hospitals
   has_many :user_activities, dependent: :destroy
   has_many :clinical_histories

   ##### validamos por email #####
   
   validates_uniqueness_of :email
   validates_presence_of :email
   #validates_format_of   :email, :with => /^[\-a-z0-9]+$/

   mount_uploader :avatar, AvatarUploader

   after_create do 
       self.register = Time.now
       self.last_loggin = Time.now
       self.salt = generate_salt
       password = self.hashed_password
       encripted = Digest::SHA2.hexdigest(password)
        if self.hashed_password != encripted
               self.hashed_password = encripted
               self.save
        end
       puts "creando el usuario #{email}"
   end

   after_destroy do 

        @dp = DoctorPatient.where(doctor_id: self.id)
        @dpx = DoctorPatient.where(patient_id: self.id)
        @dpx.each do |idp|
          idp.destroy
        end
        @dp.each do |idp|
         idp.destroy
        end
         
        ux = self.cite_doctors
        ux.destroy_all

        uz = self.notes
        uz.destroy_all

        uy = self.diagnostics
        uy.destroy_all

        uv = self.vital_signs
        uv.destroy_all

        uw = self.notes
        uw.destroy_all

        se = self.session
        se.destroy_all

   end

  def generate_salt
       o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
       string = (0...50).map { o[rand(o.length)] }.join
       salt = string
  end 

  def encripted_codification
      Digest::SHA2.hexdigest( self.salt + self.hashed_password.to_s + secure_key ) 
  end

  def secure_key
     "ragnarockdoctoremlorempacut582958209580293fknfndfs3491389341849849u35u41u31uiifnsfbnifacghrtf"
  end

  def w_digest(passtd)
     cript = Digest::SHA2.hexdigest( self.salt + passtd.to_s + secure_key )
     compare_acces(cript, encripted_codification )
  end

  def compare_acces(cript, decript)
    if cript ==  decript
        true
      else
        false
    end
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
      id_patients.push(idp.doctor_id)
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

  def my_request_from_notice
    @notices = Notice.where(:receiver_id => self.id)
  end
  
end
