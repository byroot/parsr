module Parsr::ArrayRule

  Unterminated = Class.new(Parsr::Error)

  class << self

    def match(scanner, &block)
      if scanner.scan(/\[\s*/)
        array = []
        until scanner.scan(/\s*\]/)
          if scanner.scan(/[a-zA-Z_][0-9a-zA-Z_]*\:/)
            token = Parsr::Token.new(scanner.matched.chomp(':').to_sym)
            array << parse_unclosed_hash(scanner, token, &block)
            break
          end

          token = yield 
          if token.is_a?(Parsr::Token) && scanner.scan(/\s*=>\s*/)
            array << parse_unclosed_hash(scanner, token, &block)
            break
          end
          
          array << token.value if token.is_a?(Parsr::Token)
          break unless scanner.scan(/\s*,\s*/)
        end
        Parsr::Token.new(array)
      end
    end

    def parse_unclosed_hash(scanner, token, &block)
      hash = []
      while pair = Parsr::HashRule.parse_pair(scanner, token, &block)
        token = nil
        hash << pair
        unless scanner.scan(/\s*\,\s*/)
          p scanner.rest
          puts 'break'
          break
        end
      end
      Hash[hash]
    end

  end

end
