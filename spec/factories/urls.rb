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
#  index_urls_on_token  (token) UNIQUE
#
FactoryBot.define do
  factory :url do
  end
end
