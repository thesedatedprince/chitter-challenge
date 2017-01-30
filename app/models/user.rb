require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :name, String
  property :username, String

  property :password_digest, Text

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(username, password)
  user = first(username: username)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end
