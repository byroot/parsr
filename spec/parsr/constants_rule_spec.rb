require 'spec_helper'

describe Parsr::ConstantsRule do
  include_context 'rule'

  describe '.match' do

    it 'should match nil' do
      match('nil').value.should be_nil
    end

    it 'should match false' do
      match('false').value.should be_false
    end

    it 'should match true' do
      match('true').value.should be_true
    end

  end

end
