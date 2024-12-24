class Api::V1::PingController < ApplicationController
  def index
    d = DateTime.now
    render json: { serverTime: d.to_time }, status: :ok
  end
  def test_post
    user_params = params.permit(:email, :password)
    result = ::TestDto.new(user_params)
    render json: result, status: :ok
  end
end
