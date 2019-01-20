class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|

  
      t.integer :user_id
      t.text :text
      t.integer :question_id
      t.timestamps null: false
    end
  end
end
