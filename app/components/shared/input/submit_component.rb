# frozen_string_literal: true

class Shared::Input::SubmitComponent < ViewComponent::Base
  def initialize(form:, data_target: nil)
    @form = form
    @data_target = data_target
  end
end
