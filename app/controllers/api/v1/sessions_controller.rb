module Api::V1
  class SessionsController < ApplicationController

    before_action :check_session, except: [:new]

    def new
      phone_number = params[:phoneNumber]
      access_token = params[:accountKitAccessToken]

      response = HTTP.get("https://graph.accountkit.com/v1.3/me/?access_token=#{access_token}")
      json = JSON.parse(response.body)

      phone_number = "#{json[:phone][:country_prefix]}#{json[:phone][:national_number]}"
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

    def delete
      Session.destroy(session[:session_id])
      session[:session_id] = nil

      render json: {
        success: true
      }
    end
  end
end
