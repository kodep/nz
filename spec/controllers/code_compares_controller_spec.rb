require 'spec_helper'

describe CodeComparesController do
  login_user
  let(:valid_attributes) { { "user_id" => "1" } }

  let(:valid_session) { {} }

  before do
    @code = FactoryGirl.create(:code)
    @task = FactoryGirl.create(:task)
    @game = FactoryGirl.create(:game)
    @user_task = FactoryGirl.create(:user_task, user_id: @user_id, task_id: @task.to_param)
    @task_code = FactoryGirl.create(:task_code, task_id: @task.to_param, code_id: @code.to_param)
    @task_game = FactoryGirl.create(:game_task, game_id: @game.to_param, task_id: @task.to_param)
    @user_game = FactoryGirl.create(:user_game, user_id: @user_id, game_id: @game.to_param)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CodeCompare" do
        expect {
          post :create, {:try_text => @code.attributes["code_string"], task: @task.to_param}, valid_session
        }.to change(CodeCompare, :count).by(1)
      end

      it "creates a new CodeCompare and change task" do
        @new_task = FactoryGirl.create(:task, task_text: "sdgbhdrhndrbhzsgfr")
        @new_code = FactoryGirl.create(:code, code_string: "dfbdfbndfgnhdfgdfh")
        @new_user_task = FactoryGirl.build(:user_task, user_id: @user_id, task_id: @new_task.to_param)
        @new_task_code = FactoryGirl.create(:task_code, task_id: @new_task.to_param, code_id: @new_code.to_param)
        @new_task_game = FactoryGirl.create(:game_task, game_id: @game.to_param, task_id: @new_task.to_param)
        post :create, {:try_text => @code.attributes["code_string"], task: @task.to_param}, valid_session
        expect(UserTask.last.task_id).to eq(@new_task.to_param.to_i)
      end

      it "creates a new CodeCompare and end the game of current user" do
        post :create, {:try_text => @code.attributes["code_string"], task: @task.to_param}, valid_session
        expect(UserGame.find(@user_game.to_param.to_i).state).to eq(-1)
      end

      it "creates a new CodeCompare with code mismatched result" do
        post :create, {:try_text => @code.attributes["code_string"] + "sefbgdfgbnfg", task: @task.to_param}, valid_session
        expect(response).to redirect_to(game_path(id: @game.to_param))
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