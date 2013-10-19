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

    it 'updated sys_time, user_time, real_time columns' do
      perf.send(:run_sample, sample)
      expect(sample.sys_time).to be >= 0
      expect(sample.user_time).to be >= 0
      expect(sample.real_time).to be > 0
      expect(sample.memory).to be > 0
    end
  end

end
