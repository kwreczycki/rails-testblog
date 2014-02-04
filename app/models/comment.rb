class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  #embedded_in :post, inverse_of: :comments

  field :body, type: String
  field :abusive, type: Boolean, default: false

  belongs_to :user
  belongs_to :post

  has_many :votes

  def mark_as_not_abusive
    update_attribute :abusive, false
  end

end
