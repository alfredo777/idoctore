class Institution < ActiveRecord::Base
      belongs_to :user
      mount_uploader :logo_string, InstitutionLogoUploader
      validates_presence_of :logo_string
end
