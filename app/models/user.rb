class User < ActiveRecord::Base
  include ModelSerializer

  has_secure_password

  belongs_to :role

end
