class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :group_name_id
      t.string :title
      t.text :post_content
      t.string :post_image_id
      t.timestamps
    end
  end
end
