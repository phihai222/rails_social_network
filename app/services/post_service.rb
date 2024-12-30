class PostService
  # Create a new post
  def create_post(user_id, attributes)
    Post.create(attributes.merge(user_id: user_id))
  end

  # Read a post by ID
  def find_post(post_id)
    Post.find_by(id: post_id)
  end

  # Find all posts by user ID
  def find_posts_by_user(user_id)
    Post.where(user_id: user_id)
  end

  # Update a post by ID
  def update_post(post_id, attributes)
    post = Post.find_by(id: post_id)
    return false unless post

    post.update(attributes)
    post
  end

  # Delete a post by ID
  def delete_post(post_id)
    post = Post.find_by(id: post_id)
    return false unless post

    post.destroy
  end
end
