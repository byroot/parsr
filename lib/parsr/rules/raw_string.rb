module Parsr::Rules::RawString

  class Unterminated < Parsr::SyntaxError
    message 'unterminated string meets end of file'
  end

  class << self

    def match(scanner)
      if scanner.scan(/'/)
        buffer = ''
        while chunk = (parse_content(scanner) || parse_escape(scanner))
          buffer << chunk
        end
        raise Unterminated.new(scanner) unless terminated?(scanner)
        return Parsr::Token.new(buffer)
      end
      nil
    end

    protected
    def parse_content(scanner)
      scanner.matched if scanner.scan(/[^\\']+/)
    end

    def parse_escape(scanner)
      return %q{'} if scanner.scan(/\\'/)
      return %q{\\} if scanner.scan(/\\\\/)
      return scanner.matched if scanner.scan(%r{\\[^'\\/]})
    end

    def terminated?(scanner)
      scanner.scan(/'/)
    end

  end

end