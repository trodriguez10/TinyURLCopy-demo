# frozen_string_literal: true

class Url::CardComponent < ViewComponent::Base
  def initialize(url:)
    @url = url
  end
end
