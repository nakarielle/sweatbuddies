class User < ActiveRecord::Base
  has_secure_password
  has_and_belongs_to_many :interests
  has_many :events

  validates_presence_of   :email
  validates_uniqueness_of :email, message: ": Sorry that account already exists"
  
  validates_presence_of :location
  validates_presence_of :user_name
  validates_presence_of :interests, message: ": please select at least one"

  def common_interests(user)
    common = []
    interests.each do |interest|
      common << interest if user.interests.include? interest
    end
    common
  end

  def compatible?(user)
    common_interests(user).length > 0
  end

end