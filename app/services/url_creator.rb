class UrlCreator < SolidService::Base
  def call
    url = Url.new(long_url:, token:)

    url.save ? success!(url:) : fail!(url:)
  end

  private

  def token_from_algorithm
    loop do
      # Add Salting to make different tokens for same urls
      generated_token = SecureRandom.hex

      return generated_token unless token_exists?(generated_token)
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
