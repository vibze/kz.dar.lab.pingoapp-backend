module Api::V1
  class ProfileController < ApplicationController

    before_action :check_session

    def update
      current_profile.avatar = params[:file]
      current_profile.save

      render_ok
    end

    def register_device_token
      device = Device.find_or_create_by(profile_id: current_profile.id)
      device.provider = params[:provider]
      device.push_token = params[:push_token]
      device.save

      render_ok
    end
  end
end
