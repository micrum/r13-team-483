class Sample < ActiveRecord::Base
  belongs_to :sample_group
  after_initialize :set_defaults

  validates_presence_of :code
  before_save :validate_code

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

  def validate_code
    policy = RubyCop::Policy.new
    ast = RubyCop::NodeBuilder.build(self.code)
    unless ast.accept(policy)
      errors.add(:sample_group, 'Unsafe code')
      return false
    end
  end

end
