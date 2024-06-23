# frozen_string_literal: true

class Shared::Input::TextComponent < ViewComponent::Base
  def initialize(form:, field:, label:, data_target: nil)
    @form = form
    @field = field
    @label = label
    @errors = errors
    @data_target = data_target
  end

  private

  def errors
    @form.object.errors.full_messages_for(@field).to_sentence
  end
end
