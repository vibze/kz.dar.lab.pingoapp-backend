module Api::V1
  class BuddiesController < ApplicationController

    before_action :check_session

    def list
      profile = current_profile
      buddies = []
      json = JSON.parse(request.raw_post)
      json.each do |phone_number|
        buddy_profile = Profile.find_by(phone_number: phone_number)
        if buddy_profile.present?
          buddies << Buddy.find_or_create_by(owner_profile_id: current_profile.id, buddy_profile_id: buddy_profile.id)
        end
      end

      render json: buddies.to_json
    end

    def blacklist
      buddy = Buddy.find_or_create_by(owner_profile_id: current_profile.id, buddy_profile_id: params[:buddy_id])
      buddy.is_blacklisted = true
      buddy.save

      render_ok
    end

    def unblacklist
      buddy = Buddy.find_or_create_by(owner_profile_id: current_profile.id, buddy_profile_id: params[:buddy_id])
      buddy.is_blacklisted = false
      buddy.save

      render_ok
    end
  end
end
