class CommentsController < ApplicationController
  expose_decorated(:post)
  expose_decorated(:comment)

  def index
  end

  def new
  end

  def create
    comment = post.comments.build(comment_params);
    if comment.save
      redirect_to controller:'posts', action: 'index'
    else
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
