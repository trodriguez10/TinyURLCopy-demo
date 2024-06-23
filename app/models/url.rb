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
class Url < ApplicationRecord
  has_many :visits, dependent: :destroy

  validates :long_url, presence: true,
                       format: {
                         with: %r{\A(http|https)://[^\s$.?#].[^\s]*\z}i,
                         message: 'must be a valid URL'
                       }
  validates :token, presence: true, uniqueness: true, length: { minimum: 7 }

  def shorten_url
    token.to_s
  end

  def visits_count
    visits.sum(:counter)
  end
end
