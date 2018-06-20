class ProfileController < ApplicationController
  def update
    current_profile.avatar = params[:file]
    current_profile.save

    render json: {success: true}
  end
end
