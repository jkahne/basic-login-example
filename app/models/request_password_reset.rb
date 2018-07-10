class RequestPasswordReset
  attr_reader :user, :generate_password

  def initialize(user, options ={})
    @user = user
    @generate_password = options.fetch(:generate_password, false)
  end

  def call
    now = Time.zone.now
    if generate_password
      new_password = Digest::MD5.hexdigest(Rails.application.secrets.secret_key_base + now.to_s)
      user.password = new_password
      user.password_confirmation = new_password
    end
    user.password_reset_token = unique_token
    user.password_reset_set_at = now
  end

  private

  def unique_token
    begin
      return_value = SecureRandom.base58(24)
    end while User.exists?(password_reset_token: return_value)
    return_value
  end

end
