class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, null: false
      t.text :post_name, null: false
      t.text :sentence, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
