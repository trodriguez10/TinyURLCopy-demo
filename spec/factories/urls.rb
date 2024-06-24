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
FactoryBot.define do
  factory :url do
    long_url { Faker::Internet.url }
    token { Faker::Number.number(digits: 7) }
  end
end
