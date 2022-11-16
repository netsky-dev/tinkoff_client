TinkoffClient.configure do |c|
  #c.payment_public_key = "./public.key"
  c.payment_terminal_key = ENV["TERMINAL_KEY"]
  c.payment_terminal_secret = ENV["TERMINAL_SECRET"]

  c.payout_terminal_key = ENV["PAYOUT_TERMINAL_KEY"]
  c.payout_terminal_secret = ENV["PAYOUT_TERMINAL_SECRET"]
  c.payout_certificate = "./open-api-cert.pem"
  c.payout_private_key = "./private.key"
end
