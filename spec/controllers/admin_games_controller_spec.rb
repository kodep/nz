require 'spec_helper'

describe AdminGamesController do
  login_admin

  let(:valid_attributes) { { "admin_id" => "1" } }

  let(:valid_session) { {} }

  before do
    @game = FactoryGirl.create(:game)
    @admin_game = FactoryGirl.create(:admin_game, admin_id: @admin_id, game_id: @game.to_param)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AdminGame" do
        expect {
          post :create, {:admin_game => @admin_game.attributes}, valid_session
        }.to change(AdminGame, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_game" do
      expect {
        delete :destroy, {:id => @admin_game.to_param}, valid_session
      }.to change(AdminGame, :count).by(-1)
    end
  end

end
