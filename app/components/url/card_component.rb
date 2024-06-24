# frozen_string_literal: true

class Url::CardComponent < ViewComponent::Base
  renders_many :links

  def initialize(url:, title:, size: :normal)
    @title = title
    @url = url
    @size = size
    @size_classes = size_classes
  end

  private

  def size_classes
    {
      normal: 'w-96',
      full: 'w-full max-w-screen-xl'
    }[@size] || ''
  end
end
