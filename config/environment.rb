# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => ENV['EMAIL_ADDR'],
  :password             => ENV['EMAIL_PASS'],
  :authentication       => 'plain',
  :enable_starttls_auto => true  
}