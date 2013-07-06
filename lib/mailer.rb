require 'action_mailer'

class Mailer < ActionMailer::Base
  self.logger = Logger.new(CONFIG.log)

  self.view_paths = File.dirname(__FILE__)

  self.delivery_method = :smtp

  self.smtp_settings = {
    address: CONFIG.smtp_address,
    port: CONFIG.smtp_port,
    domain: CONFIG.smtp_address,
    enable_starttls_auto: true
  }

  self.smtp_settings.merge!({
    authentication: :plain,
    user_name: CONFIG.smtp_username,
    password: CONFIG.smtp_password
  }) unless CONFIG.smtp_username.empty? || CONFIG.smtp_password.empty?

  default sender: CONFIG.from_email_address, content_type: 'text/html'

  def followers(username, total, lost, gained)
    @username = username
    @total    = total
    @lost     = lost
    @gained   = gained

    mail(
      from: CONFIG.from_email_address,
      to: CONFIG.to_email_address,
      subject: 'Your Twitter followers have changed.'
    )
  end
end
