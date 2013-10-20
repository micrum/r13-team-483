require 'spec_helper'

describe Performator do
  let(:perf) { Performator.new }

  describe '#run' do

    let(:sample_group) { Fabricate(:sample_group) }

    it 'stores something in columns' do
      perf.run(sample_group)
      sample_group.reload

      sample_group.samples.each do |sample|
        expect(sample.sys_time).to be
        expect(sample.user_time).to be
        expect(sample.memory).to be
        expect(sample.real_time).to be
        expect(sample.iterations_count).to be
      end
    end

  end

  describe '#create_bench_file' do
    let(:sample) { Fabricate(:sample) }

    it 'creates bench_file' do
      bench_file = perf.send(:create_bench_file, sample)
      expect(bench_file.read).not_to be_empty
    end

    it 'blocks in bench_file replaced with code from sample' do
      bench_file = perf.send(:create_bench_file, sample)
      contents = bench_file.read
      expect(contents).to include('arr.size')
      expect(contents).to include('arr = [0] * 1_000')
    end

  end

  describe '#run_sample' do
    let(:sample) { Fabricate(:sample) }
    let(:bad_sample) { Fabricate(:bad_sample) }
    let(:timeout_sample) { Fabricate(:timeout_sample) }

    it 'updates sys_time, user_time, real_time columns' do
      perf.send(:run_sample, sample)
      expect(sample.sys_time).to be >= 0
      expect(sample.user_time).to be >= 0
      expect(sample.real_time).to be > 0
      expect(sample.memory).to be > 0
    end

    it 'sets COMPLETED status when everything OK' do
      perf.send(:run_sample, sample)
      expect(sample.status).to eq(SampleStatus::COMPLETED)
    end

    it 'sets ERROR status for bad code' do
      perf.send(:run_sample, bad_sample)
      expect(bad_sample.status).to eq(SampleStatus::ERROR)
    end

    it 'sets TIMEOUT status for long running code' do
      perf.send(:run_sample, timeout_sample)
      sleep(Performator::TIMEOUT + 1)
      timeout_sample.reload
      expect(timeout_sample.status).to eq(SampleStatus::TIMEOUT)
    end

    it 'sets ERROR status for unsafe code `rm *`' do
      unsafe_sample = Fabricate(:unsafe_sample_1)
      perf.send(:run_sample, unsafe_sample)
      expect(unsafe_sample.status).to eq(SampleStatus::ERROR)
      expect(unsafe_sample.error).to include('Unsafe')
    end

    it 'sets ERROR status for unsafe code system("rm *")' do
      unsafe_sample = Fabricate(:unsafe_sample_2)
      perf.send(:run_sample, unsafe_sample)
      expect(unsafe_sample.status).to eq(SampleStatus::ERROR)
      expect(unsafe_sample.error).to include('Unsafe')
    end

    it 'sets ERROR status for unsafe code File.read("/etc/passwd")' do
      unsafe_sample = Fabricate(:unsafe_sample_3)
      perf.send(:run_sample, unsafe_sample)
      expect(unsafe_sample.status).to eq(SampleStatus::ERROR)
      expect(unsafe_sample.error).to include('Unsafe')
    end
  end

end
