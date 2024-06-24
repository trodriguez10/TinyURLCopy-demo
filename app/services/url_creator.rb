require 'base62-rb'

class UrlCreator < SolidService::Base
  def call
    url = Url.new(long_url:, token:)

    return success!(url:) if url.save

    url.token = nil
    fail!(url:)
  end

  private

  # If there is a collision (Collisions for MD5 have already been found)
  # it would have an infinite bucle, even more if we only use 7 chars
  # Posible solution: use a longer slice of the generated_token on each loop
  # Worst case scenario: we have a collision, this method doesnt return anything
  # And we get a Token cant be blank error
  # Url Cleaner Job should reduce the probability of Collisions by removing unused URLs
  def token_from_algorithm
    long_url_hash = Digest::MD5.hexdigest(long_url).to_i(16)
    generated_token = Base62.encode(long_url_hash)

    (7..generated_token.length).each do |length|
      slice_token = generated_token.slice(0, length)

      return slice_token unless token_exists?(slice_token)
    end
  end

  def token_exists?(token)
    Url.exists?(token:)
  end

  def token
    @token ||= url_params[:token].presence || token_from_algorithm
  end

  def long_url
    @long_url ||= url_params[:long_url].presence
  end

  def url_params
    @url_params ||= params[:url_params]
  end
end
