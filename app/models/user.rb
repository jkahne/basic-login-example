class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  validates :email, presence: true, allow_blank: false
  validates :password, length: { minimum: 6 }, allow_nil: true, on: :request_password_reset
  validates :password, length: { minimum: 6 }, allow_nil: false, on: :update

  after_initialize :set_default_role

  ROLES = %w[ exhibitor fern_admin ]

  def set_default_role
    self.role = ROLES.first unless attribute_present?('role')
  end

  def fern_adin?
    self.role == "fern_admin"
  end

  def exhibitor?
    self.role == "exhibitor"
  end
end
