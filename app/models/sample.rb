class Sample < ActiveRecord::Base

  extend EnumerateIt
  has_enumeration_for :status, :with => SampleStatus

  belongs_to :sample_group

end
