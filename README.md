# TinkoffClient

Demo version of the release wrapper around the Tinkoff Bank API for payouts and payments
in version 0.1.0, only payments work, starting from version 0.2.0, payments will also be added

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

Use for generate configuration file inside /config/initializers folders
 
    $ rails g tinkoff_client

```ruby
TinkoffClient.configure do |c|
  c.payment_public_key = "./public.key"
  c.payment_terminal_key = ENV['TERMINAL_KEY']
  c.payment_terminal_secret = ENV['TERMINAL_SECRET']
end

```
payment_terminal_key and payment_terminal_secret required options for work

using the gem is very easy!
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

in version 0.1.0 available methods
```ruby
TinkoffClient::Payment.init
TinkoffClient::Payment.confirm
TinkoffClient::Payment.get_state
TinkoffClient::Payment.cancel
TinkoffClient::Payment.check_order
TinkoffClient::Payment.send_closing_receipt
TinkoffClient::Payment.finish_authorize
```

see full trace params for request and returning response
https://www.tinkoff.ru/kassa/develop/api/payments/
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/netsky-dev/tinkoff_client
