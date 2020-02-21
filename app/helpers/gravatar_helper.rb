# frozen_string_literal: true

module GravatarHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png?d=https://res.cloudinary.com/duzqblqoj/image/upload/v1582288788/cocktail_gravatar_xgxjpf.jpg"
  end
end
