# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shared::NavbarComponent, type: :component do
  it 'renders the NavbarComponent' do
    render_inline(Shared::NavbarComponent.new)

    expect(page).to have_text('TinyURL')
  end
end
