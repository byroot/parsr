require 'spec_helper'

describe Parsr::ArrayRule do

  def match(string)
    scanner = StringScanner.new(string)
    described_class.match(scanner) { yield scanner if block_given? }
  end

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

  end

end
