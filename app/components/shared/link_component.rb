# frozen_string_literal: true

class Shared::LinkComponent < ViewComponent::Base
  def initialize(href:, text:, target: nil, kind: :primary)
    @href = href
    @text = text
    @target = target
    @kind = kind
    @classes = generate_classes
  end

  private

  def generate_classes
    "#{default_classes} #{specific_classes}"
  end

  def specific_classes
    {
      primary: primary_classes,
      secondary: secondary_classes
    }[@kind] || ''
  end

  def default_classes
    'align-middle select-none font-sans font-bold text-center uppercase transition-all '\
    'disabled:opacity-50 disabled:shadow-none disabled:pointer-events-none text-xs py-3 '\
    'px-6 active:opacity-[0.85] rounded-full'
  end

  def primary_classes
    'bg-gray-900 text-white shadow-md shadow-gray-900/10 hover:shadow-lg '\
    'hover:shadow-gray-900/20 focus:opacity-[0.85] focus:shadow-none active:shadow-none'
  end

  def secondary_classes
    'border border-gray-900 text-gray-900 hover:opacity-75 focus:ring focus:ring-gray-300'
  end
end
