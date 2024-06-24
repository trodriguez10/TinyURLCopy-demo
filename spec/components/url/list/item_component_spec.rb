# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url::List::ItemComponent, type: :component do
  it 'renders the List::Item::Component the view attached to a URL' do
    url = create(:url)
    visit = create(:visit, url:)
    visit2 = create(:visit, counter: 9999)

    render_inline(Url::List::ItemComponent.with_collection(url.visits))

    expect(page).to have_text("Remote IP: #{visit.remote_ip}")
    expect(page).not_to have_text("Remote IP: #{visit2.remote_ip}")
    expect(page).to have_text(visit.counter)
    expect(page).not_to have_text(visit2.counter)
  end

  it 'renders the List::Item::Component for all views' do
    url = create(:url)
    visit = create(:visit, url:)
    visit2 = create(:visit, url:, counter: 9999)

    render_inline(Url::List::ItemComponent.with_collection(url.visits))

    expect(page).to have_text("Remote IP: #{visit.remote_ip}")
    expect(page).to have_text("Remote IP: #{visit2.remote_ip}")
    expect(page).to have_text(visit.counter)
    expect(page).to have_text(visit2.counter)
  end
end
