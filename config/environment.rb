# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :domain         => 'hashtagpaid.com',
  :authentication => :plain,
  :address        => 'smtpout.secureserver.net',
  :port           => 3535, # Also available: 80, 25, 465 (SSL)
  :user_name      => 'hello@hashtagpaid.com',
  :password       => 'Instalaunchbox!'
}