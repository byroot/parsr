require 'spec_helper'

describe Parsr::FloatRule do

  def match(string)
    described_class.match(StringScanner.new(string))
  end

  describe '.match' do

    it 'should not match integers' do
      match('42').should be_nil
    end

    it 'should match a simple float' do
      match('42.42').value.should be == 42.42
    end

    it 'should match positive signed floats' do
      match('+42.42').value.should be == 42.42
    end

    it 'should match negative signed floats' do
      match('-42.42').value.should be == -42.42
    end

    it 'should match floats with a implicit 0 unit' do
      match('.42').value.should be == 0.42
    end

    it 'should match positive signed floats with a implicit 0 unit' do
      match('+.42').value.should be == 0.42
    end

    it 'should match negative signed floats with a implicit 0 unit' do
      match('-.42').value.should be == -0.42
    end

  end

end
