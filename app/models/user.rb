include ApplicationHelper

class User < ActiveRecord::Base
    has_many :contributions, dependent: :destroy

    def self.find_or_create_from_auth_hash(auth_hash)
        data = auth_hash.info
        user = User.where(:email => data['email']).first
        
        # Uncomment the section below if you want users to be created if they don't exist
        unless user
            user = User.create(name: data['name'],
                               email: data['email']
            )
        end
        return user
    end
    
    def token ()
       encode(email)
    end

end
