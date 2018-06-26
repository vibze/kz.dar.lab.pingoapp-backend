module Api::V1
  class SessionsController < ApplicationController

    before_action :check_session, except: [:new]

    def new
      access_token = params[:account_kit_access_token]
      phone_number = validate_token(access_token)
      if phone_number.nil?
        render json: {
          success: false
        }, status: :bad_request
      else
        profile = Profile.find_or_create_by(phone_number: phone_number)
        session = Session.create(profile: profile, access_token: access_token)

        render json: {
          accessToken: access_token,
          profile: {
            phoneNumber: phone_number,
            avatarImageUrl: profile.avatar.thumb.url
          }
        }
      end
    end

    def delete
      Session.destroy(session[:session_id])
      session[:session_id] = nil

      render_ok
    end


    protected

    def validate_token(access_token)
      begin
        response = HTTP.get("https://graph.accountkit.com/v1.3/me/?access_token=#{access_token}")
        json = JSON.parse(response.body)
        p access_token
        "#{json['phone']['country_prefix']}#{json['phone']['national_number']}"
      rescue
        nil
      end
    end
  end
end
