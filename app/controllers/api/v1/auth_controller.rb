class Api::V1::AuthController < ApplicationController
  def registration
    payload = ::RegistrationDto.new(params.permit(:email, :password))

    if payload.valid?
      # Validate existed email in database
      if User.exists?(email: payload.email)
        render json: { error: "User already exists" }, status: 409
      else
        save_user(payload)
      end
    else
      # Validation errors
      render json: { errors: payload.errors.full_messages }, status: :bad_request
    end
  end

  def login
    render json: { message: "Login successful" }, status: :ok
  end

  def save_user(new_user)
    # Save new user
    @user = User.create(new_user.to_h)

    if @user.save
      render json: { message: "User registered successfully" }, status: :created
    end
  end
end
