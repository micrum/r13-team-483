class SampleGroup < ActiveRecord::Base

  has_many :samples
  accepts_nested_attributes_for :samples, :allow_destroy => true

  def samples_results
    samples = self.samples

    data = []
    systime = []
    realtime = []
    usertime = []

    samples.each do |sample|
      systime << {sample_name: sample.title, systime: sample.sys_time}
      realtime << {sample_name: sample.title, realtime: sample.real_time}
      usertime << {sample_name: sample.title, usertime: sample.user_time}
    end
    data << {all_systime: systime, all_realtime: realtime, all_usertime: usertime }

  end

end
