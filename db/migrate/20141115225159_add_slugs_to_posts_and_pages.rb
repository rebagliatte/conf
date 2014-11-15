class AddSlugsToPostsAndPages < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, null: false, default: ''
    add_column :pages, :slug, :string, null: false, default: ''
  end
end
