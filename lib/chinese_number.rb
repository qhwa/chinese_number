require "chinese_number/version"
require "chinese_number/parser"

module ChineseNumber
  
  def self.trans( text )
    text.gsub( Parser::TOKEN ) do |word|
      Parser.new.parse( word ).to_s
    end
  end

end
