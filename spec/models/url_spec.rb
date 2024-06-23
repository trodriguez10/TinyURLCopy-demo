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
require 'rails_helper'

RSpec.describe Url, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
