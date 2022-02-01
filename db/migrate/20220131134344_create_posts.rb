class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :text, null: false, default: ""
      t.string :tag, null: true, default: ""
      t.boolean :public, null: false, default: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
