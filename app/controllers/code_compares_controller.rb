class CodeComparesController < ApplicationController
  before_action :set_code_compare, only: [:destroy]
  skip_before_filter :authorize_admin
  before_filter :check_code_compare_creation, only: [:create]
  before_filter :authenticate_user!

  def create
    #Не совсем понял как получить пароль конкретного юзера из девиза
    @user_task = UserTask.where(user_id: current_user.id).last
    @task_codes = TaskCode.where(task_id: @user_task.task_id)
    notice = ""
    @task_game = GameTask.where(task_id: @user_task.task_id).first
    @task_codes.each do |task_code|
      @code = Code.where(id: task_code.code_id, code_string: params[:try_text])
      if @code.count > 0
         new_code_compare = {user_id: current_user.id, code_id: @code.first.id}
        @code_compare = CodeCompare.new(new_code_compare)
        #respond_to do |format|
          if @code_compare.save
            notice = "Code was matched"
            if (CodeCompare.where(user_id: current_user.id, code_id: task_code.code_id).count ==
                @task_codes.count)
                @user_hints = UserHint.where(user_id: current_user.id).count
                @task = Task.find(task_code.task_id)
                points_received = @task.points - @user_hints
                @user_task.update(result: points_received)
                @new_game_task = GameTask.where("`game_id` = ? AND `task_id` <> ?", @task_game.game_id, task_code.task_id)
                if @new_game_task.count > 0
                  UserTask.create(user_id: current_user.id, task_id: @new_game_task.first.task_id)
                  notice = "Code was matched. New Task was started"
                else
                  @user_tasks = UserTask.where(user_id: current_user.id)
                  points = 0
                  @user_tasks.each do |user_task|
                    points += user_task.result
                  end
                  @user_game = UserGame.where(user_id: current_user.id, game_id: @task_game.game_id).first
                  @user_game.update(result: points, state: -1)
                  notice = "Code was matched. Game was ended"
                end
            end
          end
        #end
        break
      end
    end

    if notice == ""
      notice = "Code was not matched"
    end

    respond_to do |format|
      format.html { redirect_to game_path(id: @task_game.game_id), notice: notice }
      format.json { head :no_content }
    end
  end

  def destroy
    @code_compare.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_code_compare
    @code_compare = CodeCompare.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def code_compare_params
    params.require(:code_compare).permit(:user_id, :code_id)
  end

  protected
    def check_code_compare_creation
      unless params[:try_text] && params[:task]
        @game_task = GameTask.where(task_id: params[:task]).first
        redirect_to game_path(id: @game_task.game_id)
      end
    end

end
