class User < ApplicationRecord
    
  has_one_attached :image 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
          authentication_keys: [:email, :group_key]
  

  
  attr_accessor :group_key
  
  #association
  belongs_to :group
  has_many :questions, ->{ order("created_at DESC") }
  has_many :answers, ->{ order("updated_at DESC") }
  has_many :answered_questions, through: :answers, source: :question
  
  
  #validation
  before_validation :group_key_to_id, if: :has_group_key?
  
   
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    group_key = conditions.delete(:group_key)
    group_id = Group.where(key: group_key).first
    email = conditions.delete(:email)

    # devise認証を、複数項目に対応させる
    if group_id && email
      where(conditions).where(["group_id = :group_id AND email = :email",
        { group_id: group_id, email: email }]).first
    elsif conditions.has_key?(:confirmation_token)
      where(conditions).first
    else
      false
    end
  end
  
  
  
  def name
    "#{family_name} #{first_name}"
  end

  def name_kana
    "#{family_name_kana} #{first_name_kana}"
  end
  
  #def full_profile?
  #  if self.image && self.name() && self.name_kana
  #    return true
  #  else
  #    return false
  #  end
    # 画像、姓名、姓名カナが設定されていないとfalseを返すようにしましょう。
  #end
  
  def full_profile?
    image.present? && family_name? && first_name? && family_name_kana? && first_name_kana?
    #imageカラムはUserモデル内には存在しないために違う書き方になっている？
    #今回は、 カラム名 + ? と書くと、指定したカラムに値が存在しないときにfalseを返すというActiverecordの機能を利用しました。
    #別の書き方としてpresent?メソッド等を利用しても構いません。
  end
  
  
  private
  def has_group_key?
    group_key.present?
  end

  def group_key_to_id
    group = Group.where(key: group_key).first_or_create
    self.group_id = group.id
  end
   
   
   
  
end
