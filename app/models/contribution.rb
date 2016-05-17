class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :class_name => 'Contribution'
  has_many :replies, :class_name => 'Contribution', foreign_key: "parent_id", dependent: :destroy
  has_many :votes, :class_name => 'Vote', dependent: :destroy
  validates :user_id, presence: true
  validates :contr_subtype, presence: true, if: "contr_type=='post'"
  validates :url, presence: true, if: "contr_type=='post' and contr_subtype=='url'"
  validates :title, presence: true, if: "contr_type=='post'"
  validates :content, presence: true, if: "contr_type=='post' and contr_subtype=='text'"
  validates :url, :format => URI::regexp(%w(http https)), if: "contr_type=='post' and contr_subtype=='url'"
  validates :parent, presence: true, if: "contr_type!='post'"
  validates :user, presence: true

  validate :url_xor_text
  validate :comment_from_post


  after_initialize :init

  def init
    self.upvote ||= 0
    if self.url.blank?
      self.contr_subtype='text'
    elsif self.content.blank?
      self.contr_subtype='url'
    end
  end

  private
  def url_xor_text
    unless content.blank? ^ url.blank?
      errors.add(:type, 'Especifica només un text o una url, no els dos')
    end
  end

  def comment_from_post
    if contr_type=='comment' and parent.contr_type != 'post'
      errors.add(:parent_id, 'Un comentari s\'ha de fer sobre un post')
    end
  end
end
