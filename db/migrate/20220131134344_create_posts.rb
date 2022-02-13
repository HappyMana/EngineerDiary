class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.string :text, null: false, default: ""
      t.string :url, null: false, default: ""
      t.references :tag, foreign_key: true, null: true
      t.boolean :public, null: false, default: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
