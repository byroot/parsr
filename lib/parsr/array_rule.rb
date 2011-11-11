module Parsr::ArrayRule

  Unterminated = Class.new(Parsr::Error)

  class << self

    def match(scanner, &block)
      if scanner.scan(/\[\s*/)
        array = []
        while token = yield and token.is_a?(Parsr::Token)
          if scanner.scan(/\s*=>\s*/)
            hash = []
            while pair = Parsr::HashRule.parse_pair(scanner, token, &block)
              token = nil
              hash << pair
              break unless scanner.scan(/\s*\,\s*/)
            end
            array << Hash[hash]
          else
            array << token.value
            break unless scanner.scan(/\s*,\s*/)
          end
        end
        raise Unterminated unless scanner.scan(/\s*\]/)
        Parsr::Token.new(array)
      end
    end

  end

end
