module SessionHelper
  def check_session
    access_struct = request.headers["Authorization"].split(" ")
    if access_struct.size == 2
      access_token = access_struct[1]
      session[:session_id] = get_current_session_id(access_token)
    end

    if session[:session_id].nil?
      render json: {message: "Session not found"}, status: :unauthorized
    end
  end

  def get_current_session_id(access_token)
    current_session = Session.find_by(access_token: access_token)
    current_session.present? ? current_session.id : nil
  end

  def current_session
    session[:session_id].nil? ? nil : Session.find(session[:session_id])
  end

  def current_profile
    current_session.profile
  end
end
