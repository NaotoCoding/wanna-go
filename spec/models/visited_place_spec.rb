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
require 'rails_helper'

RSpec.describe VisitedPlace, type: :model do
  describe 'バリデーション' do
    it '正常なパラメータの時、visited_placeは有効' do
      expect(build(:visited_place)).to be_valid
    end
  end
end
