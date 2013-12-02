class AlterTranslationTables < ActiveRecord::Migration
  def change
    change_column :talk_translations, :title, :string, default: '', null: false
    # change_column :talk_translations, :abstract, :text, default: '', null: false
    change_column :post_translations, :title, :string, default: '', null: false
    change_column :post_translations, :summary, :text, default: '', null: false
    change_column :post_translations, :body, :text, default: '', null: false
  end
end
