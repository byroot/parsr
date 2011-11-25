require 'spec_helper'

describe Parsr::Rules::Symbol do
  include_context 'rule'

  it 'should match identifiers' do
    match(':_').value.should be == :_
    match(':foo').value.should be == :foo
    match(':bar42').value.should be == :bar42
  end

  it 'should not match invalid identitifers' do
    match(':42').should be_nil
    match(':-').should be_nil
  end

end
