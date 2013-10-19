require 'erb'
require 'tempfile'
require 'rbconfig'
require 'yaml'
require 'timeout'

class Performator
  RUBY = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])
  TIMEOUT = 2

  def run(sample_group_id)
    sample_group = SampleGroup.find(sample_group_id)

    sample_group.samples.each do |sample|
      run_sample(sample)
    end
  end

  private

  def run_sample(sample)
    sample.status = SampleStatus::RUNNING
    sample.save!
    file = create_bench_file(sample)
    results = run_bench_file(file)

    if results
      if results[:timeout]
        sample.status = SampleStatus::TIMEOUT
      else
        sample.sys_time = results[:sys_time]
        sample.user_time = results[:user_time]
        sample.real_time = results[:real_time]
        sample.memory = results[:memory]
        sample.iterations_count = 0
        sample.status = SampleStatus::COMPLETED
      end

      sample.save!
    else
      sample.status = SampleStatus::ERROR
      sample.error = 'results nil'
      sample.save!
    end
  rescue Exception => e
    sample.status = SampleStatus::ERROR
    sample.error = e.message
    sample.save!
  end

  def create_bench_file(sample)
    bench_template_path = Rails.root.join('app/assets/templates/bench_file.erb')
    bench_file = Tempfile.new('bench_file')
    parsed_code = parse_code(sample.code)
    init = parsed_code[:init]
    bench = parsed_code[:bench]
    erb(bench_template_path, bench_file.path, binding)

    bench_file
  end

  def run_bench_file(file)
    cmd = %Q<#{RUBY} "#{file.path}">

    results = {}

    begin
      Timeout::timeout(TIMEOUT) do
        output = `#{cmd}`
        results = YAML.load(output) rescue nil
      end
    rescue Timeout::Error => e
      results[:timeout] = true
    end

    results
  end

  def parse_code(code)
    raise 'Please keep comments in the code' if !code.include?('# benchmark')
    h = {}
    h[:init], h[:bench] = code.gsub('(do not delete the comment)', '').split('# benchmark')
    h
  end

  def erb template_file_path, output_file_path, binding
    contents = ERB.new(File.read(template_file_path), nil, '-').result binding
    File.write(output_file_path, contents)
  end

end