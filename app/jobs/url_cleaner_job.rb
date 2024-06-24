require 'sidekiq-scheduler'

class UrlCleanerJob
  include Sidekiq::Job

  # As it includes on_cascade: foregin keys on visit, it drops
  # the visit models that are not being used
  def perform
    Url.where('updated_at < ?', 2.weeks.ago).delete_all
  end
end
