class User < ActiveRecord::Base

  before_create :generate_api_key_and_secret

  def authenticate_digest(digest, supplied_date)
    date = Time.parse(supplied_date)
    if date < Time.now - 10.seconds
      return false
    end

    expected_digest = Digest::SHA1.hexdigest("#{self.api_key}\n#{self.api_secret}\n#{supplied_date}")

    digest == expected_digest
  end

  protected

  def generate_api_key_and_secret
    generate_key
    generate_secret
  end

  def generate_key
    self.api_key = loop do
      key = SecureRandom.hex(32)
      break key unless User.exists?(api_key: key)
    end
  end

  def generate_secret
    self.api_secret = SecureRandom.base64(64).tr('+/=', 'Qrt')
  end

end
