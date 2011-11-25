module Parsr::Rules::Range

  NUMBER_PATTERN = Regexp.union(Parsr::Rules::Float::PATTERN, Parsr::Rules::Integer::PATTERN)
  PATTERN = /(#{NUMBER_PATTERN})(\.{2,3})(#{NUMBER_PATTERN})/

  class << self

    def match(scanner)
      if scanner.scan(PATTERN)
        scanner.matched =~ PATTERN
        Parsr::Token.new(Range.new(cast($1), cast($3), $2.length > 2))
      end
    end

    def cast(float_or_integer)
      Integer(float_or_integer) rescue Float(float_or_integer)
    end

  end

end