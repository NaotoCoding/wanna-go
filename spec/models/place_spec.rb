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
require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'バリデーション' do
    context '正常なパラメータの場合' do
      it 'placeは有効' do
        expect(build(:place)).to be_valid
      end
    end

    context '異常なパラメータの場合' do
      it 'nameがnilの時、placeは無効' do
        expect(build(:place, name: nil)).to be_invalid
      end

      it 'nameが空文字の時、placeは無効' do
        expect(build(:place, name: '')).to be_invalid
      end

      it 'nameが31文字以上の時、placeは無効' do
        expect(build(:place, name: 'a' * 31)).to be_invalid
      end
    end
  end
end
