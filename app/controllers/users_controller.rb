class UsersController < ApplicationController
  
def show
  @users = User.all
  @user = User.find(params[:id])
  @questions = @user.answered_questions.uniq
  #uniqメソッドは、配列の中の重複する要素を取り除いた値を返してくれるメソッドです。
end


  def edit
    @user = User.find(params[:id])   

  end

  def update
    current_user.update(update_params)#create,updateなどある。引数にはハッシュを指定
    # current_userはdeviseのヘルパーメソッドです。ログイン中のユーザーのインスタンスを取得することができます。

  end
  
  def update_params
      params.require(:user).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :image)
  
  end


end
