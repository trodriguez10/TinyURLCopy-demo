# frozen_string_literal: true

class Url::List::ItemComponent < ViewComponent::Base
  with_collection_parameter :visit

  def initialize(visit:)
    @visit = visit
  end
end
