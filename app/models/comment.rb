class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  #embedded_in :post, inverse_of: :comments
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
end
