require 'erb'
require 'tempfile'
require 'rbconfig'
require 'yaml'

class Performator
  RUBY = File.join(RbConfig::CONFIG['bindir'], RbConfig::CONFIG['ruby_install_name'])

  def run(sample_group)
    sample_group.samples.each do |sample|
      run_sample(sample)
    end
  end

  private

  def run_sample(sample)
    file = create_bench_file(sample)
    results = run_bench_file(file)

    sample.sys_time = results.stime
    sample.user_time = results.utime
    sample.real_time = results.real

    sample.memory = 0
    sample.iterations_count = 0
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

    results = nil
    IO.popen(cmd, 'w+') do |io|
      output = io.read
      results = YAML.load(output) rescue nil
    end

    results
  end

  def parse_code(code)
    h = {}
    h[:init], h[:bench] = code.gsub('(do not delete the comment)', '').split('# benchmark')
    h
  end

  def erb template_file_path, output_file_path, binding
    contents = ERB.new(File.read(template_file_path), nil, '-').result binding
    File.write(output_file_path, contents)
  end

end