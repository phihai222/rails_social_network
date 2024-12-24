class Api::V1::AuthController < ApplicationController
  def registration
    payload = ::RegistrationDto.new(params.permit(:email, :password))

    puts "payload.email:: #{payload.email}"

    if payload.valid?
      render json: { message: "User registered successfully" }, status: :created
    else
      render json: { errors: payload.errors.full_messages }, status: :bad_request
    end

  end

  def login
    render json: { message: "Login successful" }, status: :ok
  end
end
