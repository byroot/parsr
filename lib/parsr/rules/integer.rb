module Parsr::Rules::Integer
  include Parsr::Rules::Numeric

  PATTERN = /#{SIGN}#{DIGITS}/

  class << self

    def match(scanner)
      if scanner.scan(PATTERN)
        Parsr::Token.new(Integer(scanner.matched))
      end
    end

  end

end