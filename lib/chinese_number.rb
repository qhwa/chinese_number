require "chinese_number/version"
require "chinese_number/parser"

module ChineseNumber
  
  class << self
    def trans text
      text.gsub( Parser::TOKEN ) do |word|
        Parser.new.parse( word ).to_s
      end
    end

    def extract text
      text.scan( Parser::TOKEN ).map do |word|
        Parser.new.parse( word )
      end
    end

    def find text
      text.scan( Parser::TOKEN ).map do |word|
        { word => Parser.new.parse( word ) }
      end
    end
  end
end
