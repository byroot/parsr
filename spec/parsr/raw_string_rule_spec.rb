# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Parsr::RawStringRule do

  def match(string)
    described_class.match(StringScanner.new(string))
  end

  describe '.match' do

    it 'should match an empty string' do
      match(%q{''}).value.should be == ''
    end

    it 'should match a simple word' do
      match(%q{'foo'}).value.should be == 'foo'
    end

    it 'should match a simple sentence' do
      match(%q{'foo bar'}).value.should be == 'foo bar'
    end

    it 'should match a simple sentence with punctuation' do
      match(%q{'foo bar.,;$?!'}).value.should be == 'foo bar.,;$?!'
    end

    it 'should match a simple string with unicode characters' do
      match(%q{'éùäüûê€¢©◊√'}).value.should be == 'éùäüûê€¢©◊√'
    end

    it 'should match a string containing double quotes' do
      match(%q{'"'}).value.should be == '"'
    end

    it 'should match a string containing a backslash' do
      match(%q{'\n'}).value.should be == '\n'
    end

    it 'should match a string containing an escaped backslash' do
      match(%q{'\\\\'}).value.should be == '\\'
    end

    it 'should match a string containing an escaped single quote' do
      match(%q{'\\''}).value.should be == "'"
    end

    it 'should raise an Parsr::RawStringRule::Unterminated if raw string is not terminated' do
      expect{
        match(%q{'bryan\\'s kitchen})
      }.to raise_error(Parsr::RawStringRule::Unterminated, "'bryan's kitchen")
    end

  end

end
