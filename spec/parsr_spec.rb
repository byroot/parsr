require 'spec_helper'

describe Parsr do

  it 'should have a VERSION' do
    Parsr::VERSION.should be_a(String)
  end

  describe '#parse' do

    let(:first_rule) { mock(:rule) }

    let(:second_rule) { mock(:rule) }

    let(:rules) { [first_rule, second_rule] }

    subject{ Parsr.new(*rules) }

    context 'call #match on all its rules' do

      it 'should raise an IllegalValue if none of theses return a token' do
        first_rule.should_receive(:match).and_return(true)
        second_rule.should_receive(:match).and_return(false)
        expect{
          subject.parse('foo')
        }.to raise_error(Parsr::IllegalValue)
      end

      it 'should return first matched token value' do
        first_rule.should_receive(:match).and_return(true)
        second_rule.should_receive(:match).and_return(Parsr::Token.new(42))
        subject.parse('foo').should be == 42
      end

    end

  end

end
