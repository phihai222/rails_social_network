class Api::V1::UserController < ApplicationController
  before_action :authorize_request
  # GET /api/v1/user/me
  def me
    @user_info = UserInfo.find_by(user_id: @current_user.id)
    render json: @user_info.to_json
  end
end
