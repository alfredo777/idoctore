class AcupunturePoint < ActiveRecord::Base
  belongs_to :acupuncture
  validates_presence_of :x_axis
  validates_presence_of :y_axis
  validates_presence_of :name
  validates_presence_of :note
  validates_presence_of :findid
end
