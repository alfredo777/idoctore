class ClinicalHistoryToDiagnostic < ActiveRecord::Base
	validates_presence_of :diagnostic
	validates_presence_of :clinical_history
	belongs_to :diagnostic
  belongs_to :clinical_history
end
