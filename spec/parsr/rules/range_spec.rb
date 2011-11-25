require 'spec_helper'

describe Parsr::Rules::Range do
  include_context 'rule'

  describe '.match' do

    it 'should match integer ranges' do
      range = match('42..43').value
      range.should be_a(Range)
      range.first.should be == 42
      range.last.should be == 43
    end

    it 'should match a simple float range' do
      range = match('42.42..43.43').value
      range.should be_a(Range)
      range.first.should be == 42.42
      range.last.should be == 43.43
    end

    it 'should match positive and negative signed float range' do
      range = match('-42.42..+42.42').value
      range.should be_a(Range)
      range.first.should be == -42.42
      range.last.should be == +42.42
    end

  end

end
