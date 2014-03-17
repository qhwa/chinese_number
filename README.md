# ChineseNumber

This ruby gem helps you convert Chinse numbers into Arab numbers. For example:

~~~ruby
require 'chinse_number'
ChinseNumber.trans "一年有三百六十五天"
#=> "1年有365天"
~~~

## Installation

Add this line to your application's Gemfile:

    gem 'chinese_number'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chinese_number

## Usage

You can use the top-level api:
~~~ruby
ChinseNumber.trans "我有十块钱"
#=> "我有10块钱"
~~~

or use the standalone parser:
~~~ruby
ChinseNumber::Parser.new.parse "一万二"
#=> 12000
~~~

## Contributing

1. Fork it ( http://github.com/<my-github-username>/chinese_number/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
