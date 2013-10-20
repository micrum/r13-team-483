class HomeController < ApplicationController
  def index
    @sample_groups = SampleGroup.order('updated_at DESC').first(6)
    @demo_group = SampleGroup.new(title: 'Benchmark demo')
    @demo_group.samples.build(title: 'Test sample', code: sample_code)
  end

  def sample_code
    <<CODE
# init (do not delete the comment)
arr = [0] * 1_000

# benchmark (do not delete the comment)
1000000.times do
  arr.size
end
CODE
  end

  def stub

  end
end
