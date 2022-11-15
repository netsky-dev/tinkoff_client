TinkoffClient.configure do |c|
  #c.payment_public_key = "./public.key"
  c.payment_terminal_key = ENV["TERMINAL_KEY"]
  c.payment_terminal_secret = ENV["TERMINAL_SECRET"]
end
