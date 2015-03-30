class ClinicalHistory < ActiveRecord::Base
	belongs_to :user
	has_many :familial_diseases
	has_many :phisical_explorations
	has_many :clinical_history_to_diagnostic
    has_many :diagnostics, through: :clinical_history_to_diagnostic
	accepts_nested_attributes_for :familial_diseases, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :phisical_explorations, :reject_if => :all_blank, :allow_destroy => true

end
