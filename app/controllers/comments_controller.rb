class CommentsController < ApplicationController

  expose_decorated(:post)
  expose_decorated(:comment)

  def index
  end

  def new
  end

  def create
    comment = post.comments.build(comment_params)
    comment.user_id = current_user.id

    if comment.save
      redirect_to controller:'posts', action: 'index'
    else
      render :new
    end
  end

  def mark_as_not_abusive
    comment.mark_as_not_abusive

    redirect_to controller:'posts', action: 'index'
  end

  def vote_up
    if self.create_vote(1)
      flash[:notice] = "Voteup !";
    else
      flash[:notice] = "Can't add twice vote to the same comment!"
    end

    redirect_to controller:'posts', action: 'index'
  end

  def vote_down
    self.create_vote(-1)
    redirect_to controller:'posts', action: 'index'
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  protected

  def create_vote(value)
    vote = comment.votes.build(
      :user => current_user.id,
      :value => value
    )
    return vote.save
  end
end
