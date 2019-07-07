require_relative 'spec_helper'

describe ChineseNumber do

  it '可以转换普通字符串' do
    expect(ChineseNumber.trans('我口袋里没有一千块钱')).to eql '我口袋里没有1000块钱'
    expect(ChineseNumber.trans('一年有三百六十五天')).to eql '1年有365天'
  end

  it '可以转换"数字+倍数"的混合' do
    expect(ChineseNumber.trans('250万')).to eql '2500000'
    expect(ChineseNumber.trans('20万')).to eql '200000'
    expect(ChineseNumber.trans('20万五千')).to eql '205000'
    expect(ChineseNumber.trans('20万零五千')).to eql '205000'
  end

  it '可以抽出数字' do
    expect(ChineseNumber.extract('每分钟六十秒的速度前进二十四小时')).to eql [60, 24]
  end

  it '可以寻找字符串内的中文数字' do
    expect(ChineseNumber.find('每分钟六十秒的速度前进二十四小时')).to eql [
      { '六十' => 60 },
      { '二十四' => 24 }
    ]
  end

end

