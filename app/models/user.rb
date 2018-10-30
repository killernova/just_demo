class User < ApplicationRecord
  has_secure_password validations: false
  attr_accessor :remember_token
  after_commit :delete_recommend_cache
  validates :email, allow_blank: false, uniqueness: true, format: {
      with: /\A[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+\Z/
  }
  has_many :articles

  def self.digest(string)
    cost = BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticate?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def recommend_number
    Rails.cache.fetch "recommend_count:#{id}", expires_in: 10.hours do
      User.where(referenced_by: reference_key).count
    end
  end
end
