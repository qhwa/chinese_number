# ChineseNumber

这个 ruby gem 可以用来解析汉语描述的数字，转换成阿拉伯数字。例如：

~~~ruby
require 'chinse_number'
ChinseNumber.trans "一年有三百六十五天"
#=> "1年有365天"
~~~

## 安装

在 Gemfile 中添加

    gem 'chinese_number'

然后运行:

    $ bundle

或者直接用 gem 安装

    $ gem install chinese_number

## 使用方法

可以用封装后的高级 api:

~~~ruby
ChinseNumber.trans "我有十块钱"
#=> "我有10块钱"

ChinseNumber.trans "二〇一四年"
#=> "2014年"
~~~

或者独立的 Parser 类:

~~~ruby
ChinseNumber::Parser.new.parse "一万二"
#=> 12000
~~~

## 协议

the MIT license

## 贡献

1. Fork ( http://github.com/qhwa/chinese_number/fork )
2. 创建一个分支 (`git checkout -b my-new-feature`)
3. 提交你的修改 (`git commit -am 'Add some feature'`)
4. push 到你的 github 仓库(`git push origin my-new-feature`)
5. 创建一个 Pull Request
