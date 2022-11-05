class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.string :text, null: true, default: ""
      t.string :url, null: false, default: ""
      t.text :site_title, :limit => 511
      t.binary :site_img, :limit => 2048
      t.boolean :is_public, null: false, default: true
      t.boolean :is_read, null: false, default: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
