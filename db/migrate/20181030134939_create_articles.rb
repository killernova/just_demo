class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.boolean :published
      t.timestamp :published_at
      t.text :body
      t.integer :user_id

      t.timestamps
    end
    add_index :articles, :user_id
  end
end
