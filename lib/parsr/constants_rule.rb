module Parsr::ConstantsRule

  class << self

    def match(scanner)
      return Parsr::Token.new(nil) if scanner.scan(/nil/)
      return Parsr::Token.new(true) if scanner.scan(/true/)
      return Parsr::Token.new(false) if scanner.scan(/false/)
    end

  end

end
