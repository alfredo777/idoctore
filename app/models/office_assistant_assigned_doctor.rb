class OfficeAssistantAssignedDoctor < ActiveRecord::Base
  belongs_to :user
  belongs_to :office_assistant
end
