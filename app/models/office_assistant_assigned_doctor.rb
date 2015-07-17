class OfficeAssistantAssignedDoctor < ActiveRecord::Base
  belongs_to :user
  belongs_to :office_assistant
  has_one :assistant_permissioning

  after_create do 
    @permissionings = AssistantPermissioning.create(office_assistant_assigned_doctor_id: self.id)
  end
end
