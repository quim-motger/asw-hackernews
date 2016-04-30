class Vote < ActiveRecord::Base
  validates :user_id, uniqueness: {scope: :contribution_id, message: 'Only one vote per user'}
end
