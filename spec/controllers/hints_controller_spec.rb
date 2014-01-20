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

describe HintsController do
  login_admin
  # This should return the minimal set of attributes required to create a valid
  # Hint. As you add validations to Hint, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HintsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before do
    @queue_number = rand(1...2)
    @task = FactoryGirl.create(:task)
    @hint = FactoryGirl.create(:hint, queue_number: @queue_number)
    @new_hint = FactoryGirl.build(:hint, queue_number: 3 - @queue_number)
    @task_hint = FactoryGirl.create(:task_hint, task_id: @task.to_param, hint_id: @hint.to_param)
    @invalid_attributes = FactoryGirl.build(:hint, hint_text: "акпыук", queue_number: 3 - @queue_number).attributes
  end

  describe "GET index" do
    it "assigns all hints as @hints" do
      get :index, {}, valid_session
      expect(assigns(:hints)).to eq([@hint])
    end
  end

  describe "GET show" do
    it "assigns the requested hint as @hint" do
      get :show, {:id => @hint.to_param}, valid_session
      expect(assigns(:hint)).to eq(@hint)
    end

  end

  describe "GET new" do
    it "assigns a new hint as @hint" do
      get :new, {task: @task.to_param}, valid_session
      expect(assigns(:hint)).to be_a_new(Hint)
    end

    it "check task hints count" do
      @new_hint = FactoryGirl.create(:hint, hint_text: "gfbdfsbgsdfgbdfg")
      @new_task_hint = FactoryGirl.create(:task_hint, task_id: @task.to_param, hint_id: @new_hint.to_param)
      get :show, {:id => @hint.to_param}, valid_session
      expect(assigns(:hint)).to eq(@hint)
    end

  end

  describe "GET edit" do
    it "assigns the requested hint as @hint" do
      get :edit, {:id => @hint.to_param}, valid_session
      expect(assigns(:hint)).to eq(@hint)
    end
  end

  describe "POST create" do
    before(:each) do
      @hint_post = @new_hint.attributes
      @hint_post[:task] = @task.to_param
      @hint_post_invalid = @invalid_attributes
      @hint_post_invalid[:task] = @task.to_param
    end
    describe "with valid params" do
      it "creates a new Hint" do
        expect {
          post :create, {:hint => @hint_post}, valid_session
        }.to change(Hint, :count).by(1)
      end

      it "assigns a newly created hint as @hint" do
        post :create, {:hint => @hint_post}, valid_session
        expect(assigns(:hint)).to be_a(Hint)
        expect(assigns(:hint)).to be_persisted
      end

      it "redirects to the created hint" do
        post :create, {:hint => @hint_post}, valid_session
        expect(response).to redirect_to(Hint.last)
      end

      it "creates a third Hint" do
        @new_hint = FactoryGirl.create(:hint, queue_number: 3 - @queue_number)
        @task_hint = FactoryGirl.create(:task_hint, task_id: @task.to_param, hint_id: @new_hint.to_param)
        expect {
          post :create, {:hint => @hint_post}, valid_session
        }.to change(Hint, :count).by(0)
      end


    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hint as @hint" do
        # Trigger the behavior that occurs when invalid params are submitted
        Hint.any_instance.stub(:save).and_return(false)
        post :create, {:hint => @hint_post_invalid}, valid_session
        expect(assigns(:hint)).to be_a_new(Hint)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Hint.any_instance.stub(:save).and_return(false)
        post :create, {:hint => @hint_post_invalid}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before (:each) do
        @valid_attributes = FactoryGirl.build(:hint, hint_text: "dzfvbzjfgnarmkgnhbmargtgbhsergnerf;").attributes
      end
      it "updates the requested hint" do
        # Assuming there are no other hints in the database, this
        # specifies that the Hint created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Hint).to receive(:update).with({ "hint_text" => "asfgasdfiasfauhguhawfjawurfh" })
        put :update, {:id => @hint.to_param, :hint => { "hint_text" => "asfgasdfiasfauhguhawfjawurfh" }}, valid_session
      end

      it "assigns the requested hint as @hint" do
        hint = Hint.create! valid_attributes
        put :update, {:id => @hint.to_param, :hint => @valid_attributes}, valid_session
        expect(assigns(:hint)).to eq(@hint)
      end

      it "redirects to the hint" do
        put :update, {:id => @hint.to_param, :hint => @valid_attributes}, valid_session
        expect(response).to redirect_to(@hint)
      end
    end

    describe "with invalid params" do
      it "assigns the hint as @hint" do
        # Trigger the behavior that occurs when invalid params are submitted
        Hint.any_instance.stub(:save).and_return(false)
        put :update, {:id => @hint.to_param, :hint => @invalid_attributes}, valid_session
        expect(assigns(:hint)).to eq(@hint)
      end

      it "re-renders the 'edit' template" do
        hint = Hint.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Hint.any_instance.stub(:save).and_return(false)
        put :update, {:id => @hint.to_param, :hint => @invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hint" do
      expect {
        delete :destroy, {:id => @hint.to_param}, valid_session
      }.to change(Hint, :count).by(-1)
    end

    it "redirects to the hints list" do
      delete :destroy, {:id => @hint.to_param}, valid_session
      expect(response).to redirect_to(hints_url)
    end
  end

end
