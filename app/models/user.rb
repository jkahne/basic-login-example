class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  validates :email, presence: true, allow_blank: false
  validates :password, length: { minimum: 6 }, allow_nil: true, on: :request_password_reset
  validates :password, length: { minimum: 6 }, allow_nil: false, on: :update

  after_initialize :set_default_role

  ROLES = %w[ standard admin ]

  def set_default_role
    self.role = ROLES.first unless attribute_present?('role')
  end

  def admin?
    self.role == "admin"
  end

  def standard?
    self.role == "standard"
  end
end
