require 'benchmark'

class VisitQueriesBenchmarkJob
  include Sidekiq::Job

  ITERATIONS = 1000

  def perform
    # Replicated records break the job
    url = Url.create(long_url: 'http://dummy.com', token: 123_456_789)
    visit = Visit.create(counter: 0, remote_ip: '127.0.0.1', url:)

    Rails.cache.write("visit:#{visit.id}:counter", 1)

    Benchmark.bm do |x|
      x.report('increment! method:') do
        ITERATIONS.times { test_increment_bang(visit) }
      end

      x.report('increment_counter + touch:') do
        ITERATIONS.times { test_increment_counter_touch(visit) }
      end

      x.report('increment_counter:') do
        ITERATIONS.times { test_increment_counter_without_touch(visit) }
      end
    end
  end

  private

  def test_increment_bang(visit)
    visit.increment!(:counter, Rails.cache.read("visit:#{visit.id}:counter").to_i)
    Rails.cache.write("visit:#{visit.id}:counter", 0)
  end

  def test_increment_counter_touch(visit)
    Visit.increment_counter(:counter, visit.id, by: Rails.cache.read("visit:#{visit.id}:counter").to_i)
    visit.url.touch
    Rails.cache.write("visit:#{visit.id}:counter", 0)
  end

  def test_increment_counter_without_touch(visit)
    Visit.increment_counter(:counter, visit.id, by: Rails.cache.read("visit:#{visit.id}:counter").to_i)
    Rails.cache.write("visit:#{visit.id}:counter", 0)
  end
end
