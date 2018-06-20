module Api::V1
  class PingsController < ApplicationController

    before_action :check_session

    def new
      buddy = Profile.find(params[:buddy_id])
      return render404(404, "Buddy not found") if buddy.nil?

      device = buddy.device
      return render404(404, "Device or device push token not found") if device.nil? || device.push_token.nil?

      if device.provider == "apns"

        notification = Houston::Notification.new(device: device.push_token)
        notification.alert = params[:ping_text]
        notification.content_available = true
        notification.sound = ''

        APN.push(notification)
      end

      Ping.create(profile_id: current_profile.id, device_id: device.id, text: params[:ping_text])
    end

    def recent
    end
  end
end
