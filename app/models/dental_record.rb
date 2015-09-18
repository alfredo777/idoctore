class DentalRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :clinical_history
  has_many :tooths
  has_many :dental_notes
  
  validates_presence_of :user_id
  validates_presence_of :doctor_id

  accepts_nested_attributes_for :tooths, :reject_if => :all_blank, :allow_destroy => true

  def doctor
    @user = User.find_by_id(self.doctor_id)
  end
end
