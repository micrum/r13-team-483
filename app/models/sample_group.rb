class SampleGroup < ActiveRecord::Base

  has_many :samples
  accepts_nested_attributes_for :samples, :allow_destroy => true

  validates_presence_of :title


  def run_benchmark
    raise RuntimeError 'Cannot run benchmark for unsaved SampleGroup' if new_record?

    samples.each do |sample|
      sample.update_attributes!(status: SampleStatus::PENDING) unless sample.status
    end

    Performator.new.delay.run(self.id)
  end

  def slowest_sample
    samples.maximum(:real_time)
  end


end
