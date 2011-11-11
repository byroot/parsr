module Parsr::ArrayRule

  Unterminated = Class.new(Parsr::Error)

  class << self

    def match(scanner)
      if scanner.scan(/\[\s*/)
        array = []
        while token = yield and token.is_a?(Parsr::Token)
          array << token.value
          scanner.scan(/\s*,\s*/) or break
        end
        raise Unterminated unless scanner.scan(/\s*\]/)
        Parsr::Token.new(array)
      end
    end

  end

end
