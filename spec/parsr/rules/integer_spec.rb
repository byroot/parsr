require 'spec_helper'

describe Parsr::Rules::Integer do
  include_context 'rule'

  describe '.match' do

    it 'should match digits' do
      result = match('42')
      result.should be_a(Parsr::Token)
      result.value.should be == 42
    end

    it 'should match only digits' do
      result = match('42abcd')
      result.should be_a(Parsr::Token)
      result.value.should be == 42
    end

    it 'should also match prepended sign' do
      result = match('+42')
      result.should be_a(Parsr::Token)
      result.value.should be == 42
      
      result = match('-42')
      result.should be_a(Parsr::Token)
      result.value.should be == -42
    end

    it 'should not return a Token if it does not match' do
      result = match('AZIJjkdjfs42|')
      result.should_not be_a(Parsr::Token)
    end

    it 'should match integers with containing an underscore for clarity' do
      result = match('1_000')
      result.should be_a Parsr::Token
      result.value.should be == 1_000
    end

    it 'should not match integers with underscore prefix' do
      result = match('_1_000')
      result.should be_nil
    end

  end

end
