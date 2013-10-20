class Sample < ActiveRecord::Base
  belongs_to :sample_group
  after_initialize :set_defaults

  private

  def set_defaults
    if new_record?
      self.code = <<CODE
# init (do not delete the comment)
arr = [0] * 1_000

# benchmark (do not delete the comment)
1000000.times do
  arr.size
end
CODE
    end
  end

end
