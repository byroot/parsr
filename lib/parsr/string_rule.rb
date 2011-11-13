module Parsr::StringRule

  ESCAPED_CHARS = {'\n' => "\n", '\b' => "\b", '\f' => "\f", '\r' => "\r", '\t' => "\t"}
  
  class Unterminated < Parsr::SyntaxError
    message 'unterminated string meets end of file'
  end

  class << self

    def match(scanner)
      if scanner.scan(/"/)
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
      scanner.matched if scanner.scan(/[^\\"]+/)
    end

    def parse_escape(scanner)
      return %q{"} if scanner.scan(/\\"/)
      return %q{\\} if scanner.scan(/\\\\/)
      return ESCAPED_CHARS[scanner.matched] if scanner.scan(/\\[bfnrt]/)
      return [Integer("0x#{scanner.matched[2..-1]}")].pack('U') if scanner.scan(/\\u[0-9a-fA-F]{4}/)
    end

    def terminated?(scanner)
      scanner.scan(/"/)
    end

  end
end