# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shared::List::ListComponent, type: :component do
  it 'renders the ListComponent' do
    render_inline(Shared::List::ListComponent.new(title: 'TinyURL List'))

    expect(page).to have_text('TinyURL List')
  end
end
