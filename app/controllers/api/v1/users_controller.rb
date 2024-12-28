class Api::V1::UsersController < ApplicationController
  before_action :authorize_request
  # GET /api/v1/users/me
  def me
    @user_info = UserInfo.find_by(user_id: @current_user.id)
    render json: UserInfoDto.from_model(@user_info), status: :ok
  end

  # PATCH /api/v1/users/me
  def update_me
    payload = UserInfoDto.new(params.permit(:firstName, :lastName, :email))

    unless payload.valid?
      render json: { error: "Invalid request data.", details: payload.errors.full_messages }, status: :bad_request
    end

    @user_info = UserService.new.update_user_info(
      @current_user.id, first_name: payload.firstName, last_name: payload.lastName)

    render json: UserInfoDto.from_model(@user_info), status: :ok
  end
end
