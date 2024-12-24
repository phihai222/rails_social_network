class Api::V1::AuthController < ApplicationController
  def registration
    payload = ::RegistrationDto.new(params.permit(:email, :password))
    service = RegistrationService.new(payload)

    unless payload.valid?
      render json: { errors: payload.errors.full_messages }, status: :bad_request
      return
    end

    if service.email_already_exists?
      render json: { error: Constant::USER_ALREADY_EXISTS }, status: :conflict
      return
    end

    if service.register_user
      render json: { message: Constant::USER_REGISTRATION_SUCCESS }, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  def login
    render json: { message: "Login successful" }, status: :ok
  end
end
