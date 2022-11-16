# TinkoffClient

Tinkoff Ruby API wrapper for payments and e2c payouts 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tinkoff_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tinkoff_client

## Usage

Use for generate configuration file
 
    $ rails g tinkoff_client

```ruby
TinkoffClient.configure do |c|
  #c.payment_public_key = "./public.key"
  c.payment_terminal_key = ENV["TERMINAL_KEY"]
  c.payment_terminal_secret = ENV["TERMINAL_SECRET"]

  c.payout_terminal_key = ENV["PAYOUT_TERMINAL_KEY"]
  c.payout_terminal_secret = ENV["PAYOUT_TERMINAL_SECRET"]
  c.payout_certificate = "./open-api-cert.pem"
  c.payout_private_key = "./private.key"
end

```
payment_public_key is optional, others are required

for example, the initialization of the payment looks like this

```ruby
TinkoffClient::Payment.init(Amount: "1000", OrderId: "1")
```

and every method return for you hash response for example method init return this
```ruby
{"Success"=>true,
 "ErrorCode"=>"0",
 "TerminalKey"=>"1111111111",
 "Status"=>"NEW",
 "PaymentId"=>"123456789",
 "OrderId"=>"3331",
 "Amount"=>1000,
 "PaymentURL"=>"https://securepayments.tinkoff.ru/q2wER3t0"}
 ```

or something like this

```ruby
 {"Success"=>false, 
 "ErrorCode"=>"9999", 
 "Message"=>"Неверные параметры.", 
 "Details"=>"Поле OrderId не должно быть пустым."}
 ```

in version 0.2.0 available methods

for Payment:
```ruby
TinkoffClient::Payment.init
TinkoffClient::Payment.confirm
TinkoffClient::Payment.get_state
TinkoffClient::Payment.cancel
TinkoffClient::Payment.check_order
TinkoffClient::Payment.send_closing_receipt
TinkoffClient::Payment.finish_authorize
```


for Payout:
```ruby
TinkoffClient::Payout.add_customer
TinkoffClient::Payout.get_customer
TinkoffClient::Payout.remove_customer
TinkoffClient::Payout.add_card
TinkoffClient::Payout.get_card_list
TinkoffClient::Payout.remove_card
TinkoffClient::Payout.init
TinkoffClient::Payout.payment
TinkoffClient::Payout.get_state

```


see full trace params for request and returning response
https://www.tinkoff.ru/kassa/develop/api/payments/
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/netsky-dev/tinkoff_client



MIT License

Copyright (c) 2022 Netsky

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
