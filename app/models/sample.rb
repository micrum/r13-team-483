class Sample < ActiveRecord::Base
  belongs_to :sample_group

  validates_presence_of :code
  before_save :validate_code

  private

  def validate_code
    policy = RubyCop::Policy.new
    ast = RubyCop::NodeBuilder.build(self.code)
    unless ast.accept(policy)
      errors.add(:sample_group, 'Unsafe code')
      return false
    end
  end

end
