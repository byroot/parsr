module Parsr::Rules::Hash

  class MissingValue < Parsr::SyntaxError
    message "unexpected '%{rest}'"
  end

  class MissingSeparator < Parsr::SyntaxError
    message "unexpected '%{rest}', expecting '=>'"
  end

  class Unterminated < Parsr::SyntaxError
    message "unexpected '%{rest}', expecting '}'"
  end

  class << self

    def match(scanner, &block)
      if scanner.scan(/\{\s*/)
        hash = []
        while pair = parse_pair(scanner, &block)
          hash << pair
          break unless scanner.scan(/\s*\,\s*/)
        end
        raise Unterminated.new(scanner) unless scanner.scan(/\s*\}\s*/)
        Parsr::Token.new(Hash[hash])
      end
    end

    def parse_pair(scanner, key=nil)
      unless key.is_a?(Parsr::Token)
        if scanner.scan(/[a-zA-Z_][0-9a-zA-Z_]*\:/)
          key = Parsr::Token.new(scanner.matched.chomp(':').to_sym)
        elsif key = yield and key.is_a?(Parsr::Token)
          raise MissingSeparator.new(scanner) unless scanner.scan(/\s*=>\s*/)
        else
          return false
        end
      end
      value = yield
      raise MissingValue.new(scanner) unless value && value.is_a?(Parsr::Token)
      [key, value].map(&:value)
    end

  end

end