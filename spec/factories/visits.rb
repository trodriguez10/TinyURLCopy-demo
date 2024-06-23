# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(1), not null
#  remote_ip  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :bigint           not null
#
# Indexes
#
#  index_visits_on_remote_ip  (remote_ip)
#  index_visits_on_url_id     (url_id)
#
# Foreign Keys
#
#  fk_rails_...  (url_id => urls.id)
#
FactoryBot.define do
  factory :visit do
  end
end
