module FeedsHelper
  def profile_image(url, size = :normal)
    url.gsub('_normal', "_#{size.to_s}")
  end
  def twitter_url(username = nil)
    'http://twitter.com/' + username
  end
  def find_link(text)
    text
  end
end
