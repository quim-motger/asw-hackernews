class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => "Contribution"
  has_many :replies, :class_name => "Contribution", foreign_key: "parent_id", dependent: :destroy
  validates :user_id, presence: true
  validates :contr_subtype, presence: true, if: "contr_type=='post'"
  validates :url, presence: true, if: "contr_type=='post' and contr_subtype=='url'"
  validates :content, presence: true, if: "contr_type=='post' and contr_subtype=='text'"
  validates :url, :format => URI::regexp(%w(http https)), if: "contr_type=='post' and contr_subtype=='url'"
  validates :title, presence: true, if: "contr_type=='post'"

  after_initialize :init

  def init
    self.upvote ||= 0
    if self.url.blank?
      self.contr_subtype='text'
    elsif self.content.blank?
      self.contr_subtype='url'
    end
  end
end
