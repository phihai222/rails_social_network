class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers["Authorization"]
    if header.present?
      token = header.split(" ").last
      decoded = JwtService.decode(token)
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: "Authorization token not provided" }, status: :unauthorized
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end
end
