module Parsr::FloatRule

  PATTERN = /[\-\+]?\d+\.\d+/

  class << self

    def match(scanner)
      if scanner.scan(PATTERN)
        Parsr::Token.new(Float(scanner.matched))
      end
    end

  end

end