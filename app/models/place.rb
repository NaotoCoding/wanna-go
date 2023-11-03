# == Schema Information
#
# Table name: places
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string           not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_places_on_group_id  (group_id)
#  index_places_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
class Place < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_one :visited_place, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }

  scope :not_visited, -> { where.missing(:visited_place) }

  def visited!(resistrant)
    raise ArgumentError, 'グループ外ユーザーは訪問済みにできません' unless group.member?(resistrant)

    create_visited_place!
  end
end
