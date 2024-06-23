class VisitsManager < SolidService::Base
  def call
    if ip_registered?
      Visit.find_by_remote_ip(remote_ip).increment!(:counter).save!

      success!(message: 'Count scheduled')
    else
      result = Visit.new(url:, remote_ip:)

      if result.save
        success!(message: 'New IP registered')
      else
        fail!(message: 'Something went wrong')
      end
    end
  end

  private

  def ip_registered?
    Url.joins(:visits).exists?(id: url.id, visits: { remote_ip: })
  end

  def remote_ip
    @remote_ip ||= params[:remote_ip]
  end

  def url
    @url ||= params[:url]
  end
end
