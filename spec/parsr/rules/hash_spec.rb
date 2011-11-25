require 'spec_helper'

describe Parsr::Rules::Hash do
  include_context 'rule'

  describe '.match' do

    it 'should be able to parse an empty hash' do
      match('{}').value.should be == {}
    end

    it 'should yield to get its content values' do
      values = [1, 2, 3, 4]

      result = match("{1 => 2, 3 => 4}") do |scanner|
        val = values.shift
        scanner.scan(Regexp.new(Regexp.escape(val.inspect)))
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == {1 => 2, 3 => 4}
    end

    it 'should not be disturbed by a trailing comma' do
      values = [1, 2, 3, 4]

      result = match("{1 => 2, 3 => 4, }") do |scanner|
        val = values.shift
        scanner.scan(/\s*/)
        scanner.scan(Regexp.new(Regexp.escape(val.inspect)))
        scanner.scan(/\s*/)
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == {1 => 2, 3 => 4}
    end

    it 'should not be disturbed by spaces around commas' do
      values = [1, 2, 3, 4]

      result = match("{1\t=>\n\r     2,    3 => 4, }") do |scanner|
        val = values.shift
        scanner.scan(/\s*/)
        scanner.scan(Regexp.new(Regexp.escape(val.inspect)))
        scanner.scan(/\s*/)
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == {1 => 2, 3 => 4}
    end

    it 'should support Ruby 1.9 hash syntax' do
      values = [1, 2, 4]

      result = match("{1 => 2, foo: 4}") do |scanner|
        val = values.shift
        scanner.scan(/\s*/)
        scanner.scan(Regexp.new(val.inspect))
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == {1 => 2, :foo => 4}
    end

  end

end
