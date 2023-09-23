require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe "GET /index" do
    it '参加しているグループ一覧画面が表示される' do
      get root_path
      expect(response).to have_http_status 200
    end
  end
end
