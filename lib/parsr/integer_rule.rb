module Parsr::IntegerRule

  class << self

    def match(scanner)
      if scanner.scan(/[\-\+]?\d+/)
        int = Integer(scanner.matched)
        Parsr::Token.new(int)
      end
    end

  end

end