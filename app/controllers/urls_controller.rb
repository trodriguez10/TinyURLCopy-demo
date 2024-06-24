class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :info]
  before_action :sync_views, only: :info

  def new; end

  def show
    if @url.present?
      VisitsHandler.call(url: @url, remote_ip: request.remote_ip)

      redirect_to @url.long_url, allow_other_host: true
    else
      redirect_to root_path, notice: 'TinyURL doesnt exist'
    end
  end

  def create
    @result = UrlCreator.call(url_params:)
    @url = @result.url
  end

  # If we have an user system, we could automatically Sync all the information
  # When he joins the page, on an async job
  # Also, maybe use turbostreams to add the new results?
  def info; end

  private

  def sync_views
    return if @url.visits.blank?

    UrlViewsSyncJob.perform_sync(@url.visits.pluck(:id))
    @url.reload
  end

  def set_url
    @url = Url.find_by_token(url_token)
  end

  def url_token
    params.permit(:token)[:token]
  end

  def url_params
    params.require(:url).permit(:long_url, :token)
  end
end
