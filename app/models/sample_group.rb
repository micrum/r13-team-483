class SampleGroup < ActiveRecord::Base

  has_many :samples
  accepts_nested_attributes_for :samples, :allow_destroy => true


  def run_benchmark
    raise RuntimeError 'Cannot run benchmark for unsaved SampleGroup' if new_record?

    Performator.new.delay.run(self.id)
  end


end
