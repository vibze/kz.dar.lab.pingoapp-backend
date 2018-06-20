require 'houston'

if Rails.env.development?
  APN = Houston::Client.development
  APN.certificate = File.read(Rails.root.join('config/push_certificates/apns_sandbox.pem'))
else
  APN = Houston::Client.production
  APN.certificate = File.read(Rails.root.join('config/push_certificates/apns_production.pem'))
end
