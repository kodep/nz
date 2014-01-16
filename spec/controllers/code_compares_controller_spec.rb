require 'spec_helper'

describe CodeComparesController do
  login_user

  let(:valid_attributes) { { "user_id" => "1" } }

  let(:valid_session) { {} }

  let(:task) { create :task }
  let(:code) { create :code }

  let(:game) { create :game }

  let!(:task_code) { create :task_code, task: task, code: code }
  let!(:user_task) { create :user_task, task: task, user: @user }
  let!(:task_game) { create :game_task, game: game, task: task }
  let!(:user_game) { create :user_game, game: game, user: @user}

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CodeCompare" do
        expect {
          post :create, {try_text: code.code_string, task: task}, valid_session
        }.to change(CodeCompare, :count).by(1)
      end

      # I didn't understand what expected to occur here
      # it "creates a new CodeCompare and change task" do
      #   new_task = create(:task, task_text: "sdgbhdrhndrbhzsgfr")
      #   new_code = create(:code, code_string: "dfbdfbndfgnhdfgdfh")
      #   # @new_user_task = FactoryGirl.build(:user_task, user_id: @user_id, task_id: @new_task.to_param)
      #   # @new_task_code = FactoryGirl.create(:task_code, task_id: @new_task.to_param, code_id: @new_code.to_param)
      #   # @new_task_game = FactoryGirl.create(:game_task, game_id: @game.to_param, task_id: @new_task.to_param)
      #   post :create, {:try_text => code.code_string, task: task}, valid_session
      #   expect(UserTask.last.task_id).to eq(new_task.id)
      # end

      it "creates a new CodeCompare and end the game of current user" do
        post :create, {:try_text => code.code_string, task: task}, valid_session
        expect(user_game.reload.state).to eq(-1)
      end

      it "creates a new CodeCompare with code mismatched result" do
        post :create, {:try_text => code.code_string + "sefbgdfgbnfg", task: task}, valid_session
        expect(response).to redirect_to(game_path(game))
      end

    end
  end

  describe "DELETE destroy" do
    it "destroys the requested code_compare" do
      @code_compare = FactoryGirl.create(:code_compare, user_id: @user_id, code_id: @code.to_param)
      expect {
        delete :destroy, {:id => @code_compare.to_param}, valid_session
      }.to change(CodeCompare, :count).by(-1)
    end
  end

end