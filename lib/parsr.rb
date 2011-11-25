require 'strscan'

class Parsr

  BASE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'parsr'))
  autoload :Rules,   "#{BASE_PATH}/rules"
  autoload :Token,   "#{BASE_PATH}/token"
  autoload :VERSION, "#{BASE_PATH}/version"

  Error = Class.new(Exception)
  IllegalValue = Class.new(Error)

  class SyntaxError < Error

    attr_reader :scanner

    def self.message(message=nil)
      @message = "Syntax error, #{message}" if message
      @message
    end

    def initialize(scanner)
      @scanner = scanner
      super(self.class.message % context)
    end

    protected
    def context
      if scanner.eos? || scanner.rest =~ /^\s*$/
        rest = 'end of string'
       else
         scanner.rest.scan(/^\s*([^\s])/)
         rest = $1
       end
      {:rest => rest}
    end

  end

  class << self

    def literal_eval(string)
      @literal_parser ||= self.new(*Parsr::Rules::All)
      @literal_parser.parse(string)
    end

  end

  attr_accessor :rules

  def initialize(*rules)
    @rules = [rules].flatten
  end

  def parse(string)
    scanner = StringScanner.new(string)
    token = parse_value(scanner)
    raise IllegalValue unless token.is_a?(Parsr::Token)
    token.value
  end

  protected
  def parse_value(scanner)
    trim_space(scanner)
    rules.each do |rule|
      token = rule.match(scanner){ parse_value(scanner) }
      return token if token.is_a?(Parsr::Token)
    end
    nil
  end

  def trim_space(scanner)
    scanner.scan(/\s+/)
  end

end
