require 'strscan'

module ChineseNumber

  class Parser
    
    def self.generate_base_map
      chinse_numbers = "一二三四五六七八九〇零".chars
      digits         = "12345678900".chars.map(&:to_i)
      Hash.new.tap do |map|
        chinse_numbers.each_with_index do |w, i|
          digit      = digits[i]
          map[w]     = digit
          map[digit] = w
        end
      end
    end

    def self.generate_multipers_map
      chinse_multipers = {
        '十' => 10,
        '百' => 100,
        '千' => 1000,
        '万' => 10000,
        '亿' => 10000_0000,
        '兆' => 10000_0000_0000
      }
    end

    DIGIT_MAP      = generate_base_map.freeze
    MULTIPERS      = generate_multipers_map.freeze
    DIGIT_TOKEN    = Regexp.new( "[#{DIGIT_MAP.keys.join}]" )
    MULTIPER_TOKEN = Regexp.new( "[#{MULTIPERS.keys.join}]" )
    TOKEN          = Regexp.new( "[#{(DIGIT_MAP.keys + MULTIPERS.keys).join}]+" )

    def parse word
      
      raise InvalidWord unless word =~ /\A#{TOKEN}\Z/

      # 类似“二零一二” 这种短语，可以直接拼数字返回
      unless word =~ MULTIPER_TOKEN
        return word.gsub(/\S/) {|w| DIGIT_MAP[w]}.to_i
      end

      @scanner = StringScanner.new( word )
      parts    = []

      while w = @scanner.scan( /\S/ )
        case w
        when DIGIT_TOKEN
          num = DIGIT_MAP[w]

          # 此处处理省略倍数的情况，例如
          # "一万五"、"八万八"
          if @scanner.eos? && parts.last && parts.last.factor >= 10
            parts << MultipedNum.new( num, parts.last.factor / 10 )
          else
            parts << MultipedNum.new( num, 1 )
          end

        when MULTIPER_TOKEN
          if parts.empty?
            parts << MultipedNum.new( 1, 1 )
          end

          multiper = MULTIPERS[w]

          if parts.last.factor <= multiper
            parts.each do |part|
              if part.factor <= multiper
                part.factor *= multiper
              end
            end
          else
            parts << MultipedNum.new( 1, multiper )
          end

        else
          raise UnexpectToken.new(w)
        end
      end

      parts.reduce(0) do |sum, part|
        sum + part.to_i
      end
    end

    class MultipedNum < Struct.new(:base, :factor)
      def to_i
        base * factor       
      end
    end

    class InvalidWord < RuntimeError
    end

  end

end
