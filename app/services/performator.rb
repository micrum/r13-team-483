class Performator
  def run(sample_group)
    sample_group.samples.each do |sample|
      run_sample sample
    end
  end

  private

  def run_sample(sample)
    sample.sys_time = rand(100)/100.0
    sample.user_time = rand(100)/100.0
    sample.real_time = rand(100)/100.0
    sample.memory = rand(100.megabytes) + 10.megabytes
    sample.iterations_count = rand(10_000)
    sample.save!
  end
end