module Parsr::RegexpRule

  OPTIONS = {
    'i' => Regexp::IGNORECASE,
    'm' => Regexp::MULTILINE,
    'x' => Regexp::EXTENDED,
  }.freeze

  class Unterminated < Parsr::SyntaxError
    message 'unterminated regexp meets end of file'
  end

  class << self

    def match(scanner)
      if scanner.scan(/\//)
        buffer = ''
        while chunk = (parse_content(scanner) || parse_escape(scanner))
          buffer << chunk
        end
        return Parsr::Token.new(Regexp.new(buffer, parse_options(scanner)))
      end
    end

    def parse_content(scanner)
      scanner.matched if scanner.scan(/[^\\\/]+/)
    end

    def parse_escape(scanner)
      return scanner.matched if scanner.scan(%r{\\.})
    end

    def parse_options(scanner)
      raise Unterminated.new(scanner) unless scanner.scan(/\/[imx]*/)
      scanner.matched[1..-1].chars.map{ |o| OPTIONS[o] }.reduce(0) { |a, b| a | b }
    end

  end

end
