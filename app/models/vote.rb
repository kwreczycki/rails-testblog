class Vote
  include Mongoid::Document

  belongs_to :user
  belongs_to :comment

  field :positive, type: Integer, default: 0
  field :negative, type: Integer, default: 0

  validates_uniqueness_of :comment, :scope => :user

  def value(value)
    if value > 0
      self.positive = value;
    else
      self.negative = value;
    end
  end
end
