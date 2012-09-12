require 'action_mailer'

class Mailer < ActionMailer::Base
  self.logger = Logger.new(CONFIG.log)

  self.view_paths = File.dirname(__FILE__)

  self.delivery_method = :smtp
  self.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'smtp.gmail.com',
    authentication: :plain,
    user_name: CONFIG.gmail_username,
    password: CONFIG.gmail_password,
    enable_starttls_auto: true
  }

  default sender: CONFIG.deliver_email, content_type: 'text/html'

  def followers(username, total, lost, gained)
    @username = username
    @total    = total
    @lost     = lost
    @gained   = gained

    mail(
      from: CONFIG.gmail_username,
      to: CONFIG.deliver_email,
      subject: 'Your Twitter followers have changed.'
    )
  end
end
