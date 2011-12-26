module Parsr::Rules::Float
  include Parsr::Rules::Numeric

  PATTERN = /#{SIGN}#{DIGITS}\.#{DIGITS}/

  class << self

    def match(scanner)
      if scanner.scan(PATTERN)
        Parsr::Token.new(Float(scanner.matched))
      end
    end

  end

end