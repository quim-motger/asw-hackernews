class User < ActiveRecord::Base
    has_many :contributions, dependent: :destroy
end
