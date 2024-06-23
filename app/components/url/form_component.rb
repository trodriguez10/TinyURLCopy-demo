# frozen_string_literal: true

class Url::FormComponent < ViewComponent::Base
  def initialize(url: Url.new)
    @url = url
  end
end
