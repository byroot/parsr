require 'spec_helper'

describe Parsr::ArrayRule do
  include_context 'rule'

  describe '.match' do

    it 'should be able to parse an empty array' do
      match('[]').value.should be == []
    end

    it 'should yield to get its content values' do
      values = [3, 2, 1]

      result = match('[1,2,3]') do |scanner|
        val = values.pop
        scanner.scan(Regexp.new(val.to_s))
        Parsr::Token.new(val)
      end
      
      result.value.should be == [1, 2, 3]
    end

    it 'should not be disturbed by a trailing comma' do
      values = [3, 2, 1]

      result = match('[1,2,3,]') do |scanner|
        val = values.pop
        scanner.scan(Regexp.new(val.to_s))
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == [1, 2, 3]
    end

    it 'should not be disturbed by spaces around commas' do
      values = [3, 2, 1]

      result = match("[ 1   ,\t2\r\n, 3  ]") do |scanner|
        val = values.pop
        scanner.scan(Regexp.new(val.to_s))
        Parsr::Token.new(val)
      end
      
      result.value.should be == [1, 2, 3]
    end

    it 'should be able to parse a final unenclosed Hash' do
      values = [6, 5, 4, 3, 2, 1]

      result = match("[1, 2, 3 => 4, 5=>6]") do |scanner|
        val = values.pop
        scanner.scan(Regexp.new(val.to_s))
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == [1, 2, {3 => 4, 5 => 6}]
    end

    it 'should be able to parse a final unenclosed Ruby1.9 Hash' do
      values = [6, 5, 4, 2, 1]

      result = match("[1, 2, foo: 4, 5=>6]") do |scanner|
        val = values.pop
        scanner.scan(/\s*/)
        scanner.scan(Regexp.new(val.to_s))
        Parsr::Token.new(val) if val
      end
      
      result.value.should be == [1, 2, {:foo => 4, 5 => 6}]
    end

  end

end
