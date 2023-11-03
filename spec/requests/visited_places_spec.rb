require 'rails_helper'

RSpec.describe 'VisitedPlaces', type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    let(:owner) { create(:user) }
    let(:group) { create(:group, owner:) }
    let(:place) { create(:place, group:) }

    it 'ログイン画面にリダイレクトされる' do
      post group_place_visited_places_path(group, place)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'POST /groups/:group_id/places/:place_id/visited_places' do
    let(:owner) { create(:user) }
    let(:group) { create(:group, owner:) }
    let(:place) { create(:place, group:) }

    before do
      sign_in owner
    end

    it 'visited_placesテーブルのレコードが1つ保存される' do
      expect do
        post group_place_visited_places_path(group, place)
      end.to change(VisitedPlace, :count).by(1)
    end

    it 'グループの詳細画面にリダイレクトされる' do
      post group_place_visited_places_path(group, place)
      expect(response).to redirect_to group_path(group)
    end
  end
end
