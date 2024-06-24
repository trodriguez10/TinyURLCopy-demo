# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url::FormComponent, type: :component do
  it 'renders the create Url form' do
    url = create(:url)
    render_inline(Url::FormComponent.new(url:))

    expect(page).to have_text('Create your TinyURL')
    expect(page).to have_text('Long Url')
    expect(page).to have_text('(Optional) Custom Alias')
    expect(page).to have_selector("input[name='url[long_url]']")
    expect(page).to have_selector("input[name='url[token]']")
  end
end
