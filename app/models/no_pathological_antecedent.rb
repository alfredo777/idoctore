class NoPathologicalAntecedent < ActiveRecord::Base
  belongs_to :clinical_history
  after_create do 
   if self.name.nil?
     self.destroy
   end
  end
end
