require_relative 'spec_helper'

describe ChineseNumber do

  it '可以转换普通字符串' do
    ChineseNumber.trans('我口袋里没有一千块钱').should == '我口袋里没有1000块钱'
    ChineseNumber.trans('一年有三百六十五天').should == '1年有365天'
  end
end

