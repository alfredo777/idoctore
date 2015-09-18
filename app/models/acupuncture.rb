class Acupuncture < ActiveRecord::Base
    has_many :acupunture_points
    belongs_to :user
    belongs_to :clinical_history
    
    validates_presence_of :findid
    validates_presence_of :user_id

    def doctor
      @doctore = User.find(self.doctor_id)
    end
end
