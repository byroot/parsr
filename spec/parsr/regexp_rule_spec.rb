# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Parsr::RegexpRule do
  include_context 'rule'

  describe '.match' do

    it 'should match an empty regexp' do
      match(%q{//}).value.should be == //
    end

    it 'should match a simple regexp' do
      match(%q{/foo/}).value.should be == /foo/
    end

    it 'should match a regexp wth space' do
      match(%q{/foo bar/}).value.should be == /foo bar/
    end

    it 'should match a regexp containing a backslash' do
      eval(%q{ /\\\\/}).should be == /\\/
      match(%q{/\\\\/}).value.should be == /\\/
    end

    it 'should match a regexp containing a metacharacters' do
      match(%q{/\d/}).value.should be == /\d/
    end

    it 'should match a regexp with options' do
      match(%q{/\d/ix}).value.should be == /\d/ix
    end

    it 'should match a regexp containing an escaped slash' do
      match(%q{/\//}).value.should be == /\//
    end

    it 'should raise an Parsr::RegexpRule::Unterminated if regexp is not terminated' do
      expect{
        match(%q{/\\/})
      }.to raise_error(Parsr::RegexpRule::Unterminated)
    end

  end

end
