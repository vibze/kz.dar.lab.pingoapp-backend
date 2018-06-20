module ResponseHelper
  def render_ok
    render json: { success: true }
  end

  def render404(code, message)
    render json: {
      success: false,
      error: {
        code: 404,
        message: message
      }
    }, status: :not_found
  end
end
