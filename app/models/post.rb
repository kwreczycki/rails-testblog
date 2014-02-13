class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end

  def hotness
    if self.comments.size.equal?(3)
      return 4
    elsif self.created_at >= 24.hours.ago
      return 3
    elsif self.created_at > 72.hours.ago and self.created_at < 24.hours.ago
      return 2
    elsif self.created_at > 7.days.ago and self.created_at <= 3.days.ago
      return 1
    elsif self.created_at <= 7.days.ago
      return 0
    end
  end
end
