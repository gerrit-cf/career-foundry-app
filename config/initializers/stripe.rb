module Stripe
  module Credentials
    PUBLISHABLE_KEY = ENV['STRIPE_PUBLISHABLE_KEY']
    SECRET_KEY      = ENV['STRIPE_SECRET_KEY']
  end
end
