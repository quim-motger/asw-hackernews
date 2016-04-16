class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => "Contribution"
  has_many :replies, :class_name => "Contribution", foreign_key: "parent_id", dependent: :destroy
  validates :user_id, presence: true

  after_initialize :init

  def init
    self.upvote ||= 0
  end
end
