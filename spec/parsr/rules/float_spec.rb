require 'spec_helper'

describe Parsr::Rules::Float do
  include_context 'rule'

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

  end

end
