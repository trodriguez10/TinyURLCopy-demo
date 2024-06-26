# frozen_string_literal: true

class Url::VisitCounterComponent < ViewComponent::Base
  def initialize(visit:)
    @visit = visit
  end
end
