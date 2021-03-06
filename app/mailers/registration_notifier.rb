##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# or storing emails locally:
#
#   set :delivery_method, :file => {
#     :location => "#{Padrino.root}/tmp/emails",
#   }
#
# and then all delivered mail will use these settings unless otherwise specified.
#

Gusy::App.mailer :registration_notifier do

  email :confirm_registration do |host_address, registration, seminar|
    from host_address
    to   registration.email
    subject "#{I18n.t('registration.confirm_mail_subject')} #{seminar.name}"
    locals :registration => registration, :seminar => seminar
    render 'confirm_registration'
  end

  email :notify_host do |host_address, registration, seminar|
    from "#{registration.full_name} <#{registration.email}>"
    to   host_address
    subject "#{I18n.t('registration.host_mail_subject')} #{seminar.name} (#{I18n.l(seminar.date_from, :format => :short)} - #{I18n.l(seminar.date_to, :format => :short)})"
    locals :registration => registration, :seminar => seminar
    render 'notify_host'
  end

  email :error do |host_address, registration, seminar, error|
    to    host_address
    from  "gusy-error"
    subject "Error: #{error.inspect}"
    body  "#{error.backtrace.join.inspect}"
  end
end
