class SampleGroup < ActiveRecord::Base

  has_many :samples
  accepts_nested_attributes_for :samples, :allow_destroy => true

  validates_presence_of :title

  def samples_results
    samples = self.samples

    data = []
    samples_results = []

    data << {title: self.title, description: self.description}

    samples.each do |sample|
      samples_results << {id: sample.id, title: sample.status, status: sample.status, systime: sample.sys_time, realtime: sample.real_time,
                          usertime: sample.user_time, memory: sample.memory}
    end
    data << {samples: samples_results}

  end

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

  def largest_sample
    samples.maximum(:memory)
  end


end
