class CommentsController < ApplicationController
  expose_decorated(:post)
  expose_decorated(:comment)

  def index
  end

  def new
  end

  def create
    comment = post.comments.build(comment_params)
    if comment.save
      redirect_to controller:'posts', action: 'index'
    else
      render :new
    end
  end

  def mark_as_not_abusive
    comment.mark_as_not_abusive
    render action: :index
  end

  def vote_up
    self.create_vote(1)
    render action: :index
  end

  def vote_down
    self.create_vote(-1)
    render action: :index
  end

  def comment_params
    params.require(:comment).permit(:body)
  end


  protected
  def create_vote(value)
    comment = Comment.find(params[:id])
    # logger.debug comment.votes.sum("value")
    vote = comment.votes.build(:user => current_user.id)
    vote.value(value);
    vote.save
  end
end
