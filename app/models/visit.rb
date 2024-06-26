# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(1), not null
#  remote_ip  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :bigint           not null
#
# Indexes
#
#  index_visits_on_remote_ip_and_url_id  (remote_ip,url_id) UNIQUE
#  index_visits_on_url_id                (url_id)
#
# Foreign Keys
#
#  fk_rails_...  (url_id => urls.id) ON DELETE => cascade
#
class Visit < ApplicationRecord
  belongs_to :url, touch: true

  validates :counter, :remote_ip, presence: true
  validates :remote_ip, uniqueness: { scope: :url_id, message: 'Error!' }

  after_create :initialize_counter_cache

  after_create_commit -> {
    broadcast_prepend_to "visits_url_#{url.id}",
    html: render_component(Url::List::ItemComponent),
    target: 'visits_list'
  }

  def increment_visit_counter
    Rails.cache.increment("visit:#{id}:counter")
    broadcast_counter
  end

  # Slower than Visit.increment_counter, but faster if we have to do url.touch
  # Two calls to the cache here
  def sync_counter
    return if cached_counter.zero?

    increment!(:counter, cached_counter)
    initialize_counter_cache
  end

  def total_counter
    counter + cached_counter
  end

  private

  def initialize_counter_cache
    Rails.cache.write("visit:#{id}:counter", 0, raw: true)
  end

  def cached_counter
    Rails.cache.read("visit:#{id}:counter", raw: true).to_i
  end

  def broadcast_counter
    # Broadcast update later to
    Turbo::StreamsChannel.broadcast_update_to(
      'visit_counter',
      target: "visit_#{id}_counter",
      html: render_component(Url::VisitCounterComponent)
    )
  end

  def render_component(component_class)
    component_class.new(visit: self).render_in(ApplicationController.new.view_context)
  end

  # This aproach doesn't load the Visit ActiveRecord object but needs to touch the Url
  # def sync_counter
  # Visit.increment_counter(:counter, id, by: $redis.get("visit:#{id}:counter").to_i)
  # $redis.set("visit:#{id}:counter", 0)
  # url.touch
  # end
end
