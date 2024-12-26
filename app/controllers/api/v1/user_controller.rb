class Api::V1::UserController < ApplicationController
  before_action :authorize_request
  # GET /api/v1/user/me
  def me
    render json: { message: "You have access to this secure action, #{@current_user.email}" }
  end
end
