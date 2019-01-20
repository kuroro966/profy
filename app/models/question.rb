class Question < ApplicationRecord
    #association
  belongs_to :user
  belongs_to :group
  has_many :answers
  has_one :feed_content, as: :content, dependent: :destroy
  
  #validation
  validates_presence_of :user_id, :text, :group_id
  
  
  #callback
  after_create :create_feed_content

  
  def user_answer(user_id)
    Answer.find_by(user_id: user_id, question_id: self.id)
    #インスタンスメソッド。_questionから呼び出す。引数として@userが指定されている。
    #Userコントローラの@user = User.find(params[:id])がUserのshowに行き_questionをparcialで参照し、
    #_questionはインスタンスメソッドをquestionモデルから呼んでいる
    #selfは省略が可能。インスタンスメソッドを読んだインスタンス自身（レシーバ）（queation?）のidを見る。
  end
  
  def answered?(user)
    Answer.exists?(user_id: user.id)
    answers.exists?(user_id: user.id)
      # レシーバである質問に、現在ログインしているユーザーが既に回答している場合はtrueを、回答していない場合はfalseを返す
  end
  
  
  
  private
  def create_feed_content
    self.feed_content = FeedContent.create(group_id: group_id, updated_at: updated_at)
  end
  
  
end
