module Parsr::Rules::Array

  class Unterminated < Parsr::SyntaxError
    message "unexpected '%{rest}', expecting ']'"
  end

  class << self

    def match(scanner, &block)
      if scanner.scan(/\[\s*/)
        array = []
        begin
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
        end while scanner.scan(/\s*,\s*/)
        raise Unterminated.new(scanner) unless scanner.scan(/\s*\]/)
        Parsr::Token.new(array)
      end
    end

    def parse_unclosed_hash(scanner, token, &block)
      hash = []
      while pair = Parsr::Rules::Hash.parse_pair(scanner, token, &block)
        token = nil
        hash << pair
        break unless scanner.scan(/\s*\,\s*/)
      end
      Hash[hash]
    end

  end

end
