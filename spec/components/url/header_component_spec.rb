# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url::HeaderComponent, type: :component do
  it 'renders the title' do
    render_inline(Url::HeaderComponent.new(title: 'Header Title'))

    expect(page).to have_text('Create your TinyURL')
  end
end
