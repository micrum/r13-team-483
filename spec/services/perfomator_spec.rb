require 'spec_helper'

describe Performator do

  describe '#run' do
    let(:perf) { Performator.new }
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

end
