class QuestionsController < ApplicationController
  
  def create
    Question.create(create_params)
    redirect_to :root and return
  end
  
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
  end
  
  
  
  def create_params
    params.require(:question).permit(:text).merge(user_id: current_user.id, group_id: current_user.group_id)
    #paramsにはuseridとgroupidは送られないためmergeでくっつけてcreateの引数に渡す？
 
  end
  
end
