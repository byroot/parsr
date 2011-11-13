module Parsr::SymbolRule

  class << self

    def match(scanner)
      if scanner.scan(/\:[a-zA-Z_][0-9a-zA-Z_]*/)
        Parsr::Token.new(scanner.matched[1..-1].to_sym)
      end
    end

  end

end
