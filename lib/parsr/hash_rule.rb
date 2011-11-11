module Parsr::HashRule

  MissingSeparator = Class.new(Parsr::Error)
  MissingValue = Class.new(Parsr::Error)
  Unterminated = Class.new(Parsr::Error)

  class << self

    def match(scanner, &block)
      if scanner.scan(/\{\s*/)
        hash = []
        while pair = parse_pair(scanner, &block)
          hash << pair
          break unless scanner.scan(/\s*\,\s*/)
        end
        raise Unterminated unless scanner.scan(/\s*\}\s*/)
        Parsr::Token.new(Hash[hash])
      end
    end

    protected
    def parse_pair(scanner)
      if key = yield and key.is_a?(Parsr::Token)
        raise MissingSeparator unless scanner.scan(/\s*=>\s*/)
        value = yield
        raise MissingValue unless value && value.is_a?(Parsr::Token)
        [key, value].map(&:value)
      end
    end

  end

end