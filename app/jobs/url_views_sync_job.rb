require 'sidekiq-scheduler'

class UrlViewsSyncJob
  include Sidekiq::Job

  def perform(visits = nil)
    visits_to_sync(visits).find_each(batch_size: 1000, &:sync_counter)
  end

  private

  def visits_to_sync(visits)
    return Visit.where(id: visits) if visits.present?

    Visit.all
  end

  # Clean cache?
end
