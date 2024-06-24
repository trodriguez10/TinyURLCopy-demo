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
#  index_visits_on_remote_ip_and_url_id  (remote_ip,url_id) UNIQUE
#  index_visits_on_url_id                (url_id)
#
# Foreign Keys
#
#  fk_rails_...  (url_id => urls.id) ON DELETE => cascade
#
require 'rails_helper'

RSpec.describe Visit, type: :model do
  it 'has a valid factory' do
    expect(build(:visit)).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:counter) }
    it { is_expected.to validate_presence_of(:remote_ip) }
    it {
      is_expected.to validate_uniqueness_of(:remote_ip).scoped_to(:url_id).with_message('Error!')
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to :url }
  end
end
