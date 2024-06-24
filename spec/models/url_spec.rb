# == Schema Information
#
# Table name: urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_long_url  (long_url) UNIQUE
#  index_urls_on_token     (token) UNIQUE
#
require 'rails_helper'

RSpec.describe Url, type: :model do
  it 'has a valid factory' do
    expect(build(:url)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:long_url) }
    it { is_expected.to validate_uniqueness_of(:long_url) }
    it { is_expected.to allow_value('http://example.com').for(:long_url) }
    it { is_expected.to allow_value('https://example.com').for(:long_url) }
    it {
      is_expected.not_to allow_value('example.com').for(:long_url)
                                                   .with_message('must be a valid URL')
    }

    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:token) }
    it { is_expected.to validate_length_of(:token).is_at_least(7) }
  end

  describe 'associations' do
    it { is_expected.to have_many :visits }
  end
end
