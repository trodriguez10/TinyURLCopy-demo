class VisitsHandler < SolidService::Base
  def call
    # visit.increment_visit_counter and return success! if visit.present?
    # create_visit and return success!

    visit.present? ? visit.increment_visit_counter : create_visit

    success!
  end

  private

  def create_visit
    Visit.create(url:, remote_ip:)
  end

  def visit
    @visit ||= Visit.joins(:url).find_by(remote_ip:, url: { id: url.id })
  end

  def remote_ip
    @remote_ip ||= params[:remote_ip]
  end

  def url
    @url ||= params[:url]
  end
end
