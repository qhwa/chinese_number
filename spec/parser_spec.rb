require_relative 'spec_helper'

describe ChineseNumber::Parser do

  before(:each) do
    @parser = ChineseNumber::Parser.new
  end

  it '可以解析连续的数字' do
    test '一二三', 123
    test '二零一二', 2012
    test '二〇一二', 2012
  end

  it '可以解析个位数字' do
    test '零', 0
    test '〇', 0
  
    '一二三四五六七八九'.each_char.to_a.each_with_index do |w, i|
      test w, i + 1
    end
  end

  it '可以解析两位数字' do
    test '十',      10
    test '十一',    11
    test '一十一',  11
    test '二十',    20
    test '二十一',  21
    test '九十八',  98
  end

  it '可以解析三位数字' do
    test '百',          100
    test '一百',        100
    test '一百一十五',  115
    test '一百十五',    115
    test '一百零五',    105
  end

  it '可以解析四位数字' do
    test '千',            1000
    test '五千',          5000
    test '五千八百',      5800
    test '五千八百一十',  5810
    test '五千八百一十六', 5816
    test '五千零一十六',  5016
    test '五千一十六',    5016
    test '五千零六',      5006
  end

  it '可以解析省略部分倍数的数字' do
    test '五千六',        5600
  end

  it '可以解析五位数字' do
    test '万', 10000
    test '一万', 10000
    test '一万三', 13000
    test '一万三千', 13000
    test '一万三千八百', 13800
    test '一万三千零八十', 13080
    test '一万三千零八', 13008
    test '一万零八', 10008
    test '一万零', 10000
  end

  it '可以解析六位数字' do
    test '十万', 10_0000
    test '三十万八千', 30_8000
  end

  it '可以解析七位数字' do
    test '一百万', 100_0000
    test '一百二十万', 120_0000
    test '一百二十四万', 124_0000
  end

  it '可以解析更大的数字' do
    test '一百三十二万五千六百八十九亿八千万', 132_5689_8000_0000
  end

  it '可以解析一些特殊的数字' do
    test '万万', 10000_0000
    test '十万八千', 10_8000
  end

  it '对于不合法的文字抛出错误' do
    expect {
      @parser.parse('没有数字').should
    }.to raise_error( ChineseNumber::Parser::InvalidWord )
  end

  it '可以解析汉字和数字混用的情形' do
    test '3千万', 3000_0000
  end

  it '支持纯阿拉伯数字' do
    test '3134', 3134
  end

  def test word, expect_digit
    @parser.parse( word ).should == expect_digit
  end

end
