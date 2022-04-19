class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_secure_password
    before_destroy :check_admin_num

    scope :is_admin, -> { where(admin: true) }

    def self.authenticate(email, password) 
        user = User.find_by(email: email.downcase)
        return user if user &.authenticate(password)
    end

    private
    def check_admin_num
        if admin && User.is_admin.count == 1
            throw :abort
        end
    end
end
