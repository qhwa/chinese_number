require_relative 'spec_helper'

describe ChineseNumber do

  it '可以转换普通字符串' do
    ChineseNumber.trans('我口袋里没有一千块钱').should == '我口袋里没有1000块钱'
    ChineseNumber.trans('一年有三百六十五天').should == '1年有365天'
  end

  it '可以抽出数字' do
    ChineseNumber.extract('每分钟六十秒的速度前进二十四小时').should == [60, 24]
  end

  it '可以寻找字符串内的中文数字' do
    ChineseNumber.find('每分钟六十秒的速度前进二十四小时').should == [
      { '六十' => 60 },
      { '二十四' => 24 }
    ]
  end

end

