module Parsr::Rules
  BASE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'rules'))
  autoload :All,        "#{BASE_PATH}/all"
  autoload :Array,      "#{BASE_PATH}/array"
  autoload :Constants,  "#{BASE_PATH}/constants"
  autoload :Float,      "#{BASE_PATH}/float"
  autoload :Hash,       "#{BASE_PATH}/hash"
  autoload :Integer,    "#{BASE_PATH}/integer"
  autoload :Numeric,    "#{BASE_PATH}/numeric"
  autoload :Range,      "#{BASE_PATH}/range"
  autoload :Regexp,     "#{BASE_PATH}/regexp"
  autoload :RawString,  "#{BASE_PATH}/raw_string"
  autoload :String,     "#{BASE_PATH}/string"
  autoload :Symbol,     "#{BASE_PATH}/symbol"
end