class Institution < ActiveRecord::Base
      belongs_to :user

      mount_uploader :logo_string, InstitutionLogoUploader


end
