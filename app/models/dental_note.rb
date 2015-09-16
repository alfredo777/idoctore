class DentalNote < ActiveRecord::Base

  belongs_to :dental_record
  validates_presence_of :note
  validates_presence_of :dental_record_id
  validates_presence_of :new_treatment
  validates_presence_of :doctor_id

  def doctor
    @user = User.find(self.doctor_id)
  end
end
