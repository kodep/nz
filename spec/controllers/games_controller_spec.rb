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

describe GamesController do
  login_admin
  # This should return the minimal set of attributes required to create a valid
  # Game. As you add validations to Game, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    @game = FactoryGirl.create(:game)
    @invalid_attributes = FactoryGirl.build(:game, title: "впирапеи", start_date: "01.01.2014 00:00:00".to_datetime, duration: 11).attributes
  end

  describe "GET index" do
    it "assigns all games as @games" do
      get :index, {}, valid_session
      expect(assigns(:games)).to eq([@game])
    end
  end

  describe "GET show" do
    it "assigns the requested game as @game" do
      get :show, {:id => @game.to_param}, valid_session
      expect(assigns(:game)).to eq(@game)
    end
  end

  describe "GET new" do
    it "assigns a new game as @game" do
      get :new, {}, valid_session
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe "GET edit" do
    it "assigns the requested game as @game" do
      get :edit, {:id => @game.to_param}, valid_session
      expect(assigns(:game)).to eq(@game)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, {:game => @game.attributes}, valid_session
        }.to change(Game, :count).by(1)
      end

      it "assigns a newly created game as @game" do
        post :create, {:game => @game.attributes}, valid_session
        expect(assigns(:game)).to be_a(Game)
        expect(assigns(:game)).to be_persisted
      end

      it "redirects to the created game" do
        post :create, {:game => @game.attributes}, valid_session
        expect(response).to redirect_to(Game.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game as @game" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post :create, {:game => @invalid_attributes}, valid_session
        expect(assigns(:game)).to be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post :create, {:game => @invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before (:each) do
        @valid_attributes = FactoryGirl.build(:game, title: "title_1").attributes
      end
      it "updates the requested game" do
        # Assuming there are no other games in the database, this
        # specifies that the Game created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Game).to receive(:update).with({ "title" => "1234567890" })
        put :update, {:id => @game.to_param, :game => { "title" => "1234567890" }}, valid_session
      end

      it "assigns the requested game as @game" do
        put :update, {:id => @game.to_param, :game => @valid_attributes}, valid_session
        expect(assigns(:game)).to eq(@game)
      end

      it "redirects to the game" do
        put :update, {:id => @game.to_param, :game => @valid_attributes}, valid_session
        expect(response).to redirect_to(@game)
      end
    end

    describe "with invalid params" do
      it "assigns the game as @game" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        put :update, {:id => @game.to_param, :game => @invalid_attributes}, valid_session
        expect(assigns(:game)).to eq(@game)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        put :update, {:id => @game.to_param, :game => @invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game" do
      expect {
        delete :destroy, {:id => @game.to_param}, valid_session
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      delete :destroy, {:id => @game.to_param}, valid_session
      expect(response).to redirect_to(games_url)
    end
  end

end
