module Parsr::Rules::Symbol

  PATTERN = /\:[a-zA-Z_][0-9a-zA-Z_]*/

  class << self

    def match(scanner)
      if scanner.scan(PATTERN)
        Parsr::Token.new(scanner.matched[1..-1].to_sym)
      end
    end

  end

end
