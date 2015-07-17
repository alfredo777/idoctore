class OfficeAssistant < ActiveRecord::Base
  has_many :office_assistant_assigned_doctors
  has_many :users, through: :office_assistant_assigned_doctors
  
  validates_uniqueness_of :email
  validates_presence_of :email

  after_create do
    password = encripted_password(self.password)
    if self.password != password
       self.password = password
       self.save
    end
  end

  def encripted_password(pass)
   @pass = Digest::SHA2.hexdigest(pass)
  end

end
