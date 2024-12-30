class Api::V1::PostsController < ApplicationController
  before_action :authorize_request

  def me
    posts = PostService.new.find_posts_by_user(@current_user.id)
    render json: posts, status: :ok
  end

  def create
    content = params.permit(:content)
    post = PostService.new.create_post(@current_user.id, content)
    render json: post, status: :created
  end

  def show
    post = PostService.new.find_post(params.require(:id))

    if post.nil?
      render json: { error: "Post not found" }, status: :not_found
      return
    end

    render json: post, status: :ok
  end

end
