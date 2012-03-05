require 'digest/sha2'

class User < ActiveRecord::Base
    has_many :tweets

    validates_length_of :username, :within => 3..40
    validates_length_of :password, :within => 5..40
    validates_presence_of :username, :password, :password_confirmation, :salt
    validates_uniqueness_of :username
    validates_confirmation_of :password

    attr_accessor :password_confirmation
    attr_reader :password

    validate :password, :password_must_be_present

    def password=(password)
        @password = password

        if password.present?
            generate_salt
            self.hashed_password = self.class.encrypt_password(password,salt)
        end
    end


    class << self
        def authenticate(name, pass)
            if user = find_by_username(name)
                if user.hashed_password == encrypt_password(pass, user.salt)
                    user
                end
            end
        end
 
        def encrypt_password(password, salt)
            Digest::SHA2.hexdigest( password + "apple" + salt )
        end

    end

    private

    def password_must_be_present
        errors.add(:password, "Missing Password") unless hashed_password.present?
    end

    def generate_salt 
        self.salt = self.object_id.to_s + rand.to_s
    end
end
