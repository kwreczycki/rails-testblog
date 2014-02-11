class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :post

  field :body, type: String
  field :abusive, type: Boolean, default: false

  has_many :votes

  def mark_as_not_abusive
    update_attribute :abusive, false
  end

  def mark_as_abusive
    update_attribute :abusive, true
  end

  def self.get_all(current_user, post_id)
    post = Post.find(post_id)

    if !current_user.owner? post
      comments = post.comments

      comments.each do |comment|
        if comment.abusive
          comments.delete(comment)
        end
      end
    else
      comments = post.comments
    end

    return comments
  end
end
