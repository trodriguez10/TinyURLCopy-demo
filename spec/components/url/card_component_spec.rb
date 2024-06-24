# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url::CardComponent, type: :component do
  it 'renders the Card Component with...' do
    url = create(:url)
    render_inline(Url::CardComponent.new(url:))

    expect(page).to have_text('TinyURL created!')
    expect(page).to have_text(url.long_url)
    expect(page).to have_text(url.shorten_url)
  end
end
