# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shared::Input::TextComponent, type: :component do
  it 'renders the TextComponent' do
    render_inline(Shared::Input::TextComponent.new(title: 'TinyURL Lidast'))

    expect(page).to have_text('TinyURL List')
  end
end
