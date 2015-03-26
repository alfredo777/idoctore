class ClinicalHistory < ActiveRecord::Base
	belongs_to :user
	has_many :familial_diseases
	has_many :phisical_explorations
	accepts_nested_attributes_for :familial_diseases, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :phisical_explorations, :reject_if => :all_blank, :allow_destroy => true

end
