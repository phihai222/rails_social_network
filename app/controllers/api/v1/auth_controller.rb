class Api::V1::AuthController < ApplicationController
  def registration
    render json: { message: "User registered successfully" }, status: :created
  end

  def login
    render json: { message: "Login successful" }, status: :ok
  end
end
