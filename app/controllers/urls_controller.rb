class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :info]

  def new; end

  def show
    if @url.present?
      VisitsManager.call(url: @url, remote_ip: request.remote_ip)

      redirect_to @url.long_url, allow_other_host: true
    else
      redirect_to root_path, notice: 'TinyURL doesnt exist'
    end
  end

  def create
    result = UrlCreator.call(url_params:)
    @component = build_component(result)
  end

  def info
    # Call redis services to update the counters and views
  end

  private

  def set_url
    @url = Url.find_by_token(url_token)
  end

  def build_component(result)
    component_class = result.success? ? Url::CardComponent : Url::FormComponent
    component_class.new(url: result.url)
  end

  def url_token
    params.permit(:token)[:token]
  end

  def url_params
    params.require(:url).permit(:long_url, :token)
  end
end
