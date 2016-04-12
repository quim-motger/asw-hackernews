class User < ActiveRecord::Base
    has_many :contributions
end
