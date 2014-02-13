class CommentDecorator < Draper::Decorator
  decorates :comment
  delegate_all

  def friendly_date
    created_at.strftime("%d/%m/%Y : %R")
  end
end
