class ClinicalHistory < ActiveRecord::Base
	belongs_to :user
	has_many :familial_diseases
	has_many :phisical_explorations
	has_many :clinical_history_to_diagnostic
  has_many :diagnostics, through: :clinical_history_to_diagnostic
  has_many :no_pathological_antecedents
  has_many :pathological_antecedents
  has_many :vital_signs
	accepts_nested_attributes_for :familial_diseases, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :phisical_explorations, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :pathological_antecedents, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :no_pathological_antecedents, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :vital_signs, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :interview
  validates_presence_of :diagnostic
  validates_presence_of :suffering
	def vital_sign
		if self.vital_sign_id != nil
		  @vital_sign = VitalSign.find(self.vital_sign_id)
	    else
		   @vital_sign = false
		end
	end

end
