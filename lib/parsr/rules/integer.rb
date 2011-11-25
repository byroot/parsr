module Parsr::Rules::Integer

  PATTERN = /[\-\+]?\d+/

  class << self

    def match(scanner)
      if scanner.scan(PATTERN)
        Parsr::Token.new(Integer(scanner.matched))
      end
    end

  end

end