class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_secure_password

    def self.authenticate(email, password) 
        user = User.find_by(email: email)
        return user if user && user.authenticate(password)
    end
end
