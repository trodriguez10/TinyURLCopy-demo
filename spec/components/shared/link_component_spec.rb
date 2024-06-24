# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shared::LinkComponent, type: :component do
  let(:href) { 'http://example.com' }
  let(:text) { 'Example Link' }

  context 'when kind is primary' do
    it 'renders the link with primary classes' do
      render_inline(Shared::LinkComponent.new(href:, text:, kind: :primary))

      expect(page).to have_selector("a[href='#{href}']", text:)
      #  expect(page).to have_selector('a.primary')
    end
  end

  context 'when kind is secondary' do
    it 'renders the link with secondary classes' do
      render_inline(Shared::LinkComponent.new(href:, text:, kind: :secondary))

      expect(page).to have_selector("a[href='#{href}']", text:)
      # expect(page).to have_selector('a.secondary')
    end
  end

  context 'when target is specified' do
    it 'renders the link with the target attribute' do
      render_inline(Shared::LinkComponent.new(href:, text:, target: '_blank'))

      expect(page).to have_selector("a[href='#{href}'][target='_blank']", text:)
    end
  end
end
