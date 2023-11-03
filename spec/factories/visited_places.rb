# == Schema Information
#
# Table name: visited_places
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :bigint           not null
#
# Indexes
#
#  index_visited_places_on_place_id  (place_id)
#
# Foreign Keys
#
#  fk_rails_...  (place_id => places.id)
#
FactoryBot.define do
  factory :visited_place do
    place
  end
end
