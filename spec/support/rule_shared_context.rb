shared_context 'rule' do

  def match(string)
    scanner = StringScanner.new(string)
    described_class.match(scanner) { yield scanner if block_given? }
  end

end