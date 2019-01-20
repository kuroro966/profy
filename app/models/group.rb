class Group < ApplicationRecord
  has_many :users
  has_many :questions, ->{ order("created_at DESC") }
    #今回モデルで指定したorderオプションは -> という lambda(ラムダ)記法 で指定されています。lambdaは匿名関数のことを指し、アソシエーションでオプション指定をする際に用います。
  #lambdaそのものを理解することはかなり難しいため、今回は アソシエーションでオプションをつける際に利用する と捉えていただければ問題ありません。
  has_many :feed_contents, ->{ order("updated_at DESC") }
end
