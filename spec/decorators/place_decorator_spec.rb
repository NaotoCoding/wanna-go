require 'rails_helper'

RSpec.describe PlaceDecorator do
  describe '#display_description' do
    it 'descriptionが登録されている時、descriptionを返す' do
      place = create(:place)
      expect(place.decorate.display_description).to eq place.description
    end

    it 'descriptionが登録されていない時、"説明が登録されていません。"を返す' do
      place = create(:place, description: nil)
      expect(place.decorate.display_description).to eq '説明が登録されていません。'
    end
  end
end
