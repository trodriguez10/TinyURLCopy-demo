# frozen_string_literal: true

class Shared::List::ListComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
