require 'strscan'

class Parsr

  BASE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'parsr'))

  autoload :ArrayRule,      File.join(BASE_PATH, 'array_rule')
  autoload :FloatRule,      File.join(BASE_PATH, 'float_rule')
  autoload :IntegerRule,    File.join(BASE_PATH, 'integer_rule')
  autoload :RawStringRule,  File.join(BASE_PATH, 'raw_string_rule')
  autoload :StringRule,     File.join(BASE_PATH, 'string_rule')
  autoload :Token,          File.join(BASE_PATH, 'token')
  autoload :VERSION,        File.join(BASE_PATH, 'version')

  Error = Class.new(Exception)
  IllegalValue = Class.new(Error)

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
