require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GameHintsController do
  login_admin
  # This should return the minimal set of attributes required to create a valid
  # GameHint. As you add validations to GameHint, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "game_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GameHintsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    @game = FactoryGirl.create(:game)
    @hint = FactoryGirl.create(:hint)
    @game_hint = FactoryGirl.create(:game_hint, game_id: @game.to_param, hint_id: @hint.to_param)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new GameHint" do
        expect {
          post :create, {:game_hint => @game_hint.attributes}, valid_session
        }.to change(GameHint, :count).by(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game_hint" do
      expect {
        delete :destroy, {:id => @game_hint.to_param}, valid_session
      }.to change(GameHint, :count).by(-1)
    end
  end

end
