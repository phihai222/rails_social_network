class Api::V1::AuthController < ApplicationController
  def registration
    payload = ::AuthDto.new(params.permit(:email, :password))
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
      otp_service = OtpService.new
      otp = otp_service.generate_and_store_otp(payload.email)
      render json: { message: Constant::USER_REGISTRATION_SUCCESS, otp: otp.as_json }, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  def validate_otp
    email = params[:email]
    otp_code = params[:otp_code]

    if email.blank? || otp_code.blank?
      render json: { error: "Email and OTP code must be provided" }, status: :bad_request
      return
    end

    if OtpService.new.validate_otp(email, otp_code)
      RegistrationService.new(email: email).activate_user(email)
      render json: { message: "OTP validated successfully" }, status: :ok
    else
      render json: { error: "Invalid OTP or expired OTP" }, status: :unauthorized
    end
  end

  def login
    payload = ::AuthDto.new(params.permit(:email, :password))
    payload.skip_password_validation = true

    # Validate data
    unless payload.valid?
      render json: { errors: payload.errors.full_messages }, status: :bad_request
      return
    end

    # Check user existed or not
    user = User.find_by(email: payload.email)
    if user.nil?
      render json: { error: "Invalid email or password" }, status: :not_found
      return
    end

    # If existed, validate hash password
    unless user.authenticate(payload.password)
      render json: { error: "Invalid email or password" }, status: :unauthorized
      return
    end

    # If password valid, check active == true
    unless user.active
      otp_service = OtpService.new
      otp = otp_service.generate_and_store_otp(user.email)
      render json: { message: "Account inactive. OTP sent", otp: otp.as_json }, status: :unauthorized
      return
    end

    # If password is valid and active == true
    # TODO generate JWT Token
    render json: { message: "Login successful" }, status: :ok
  end
end
