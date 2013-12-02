class AlterTalkAbstract < ActiveRecord::Migration
  def change
    change_column :talks, :abstract, :text, default: ''
    change_column :talk_translations, :abstract, :text, default: ''
  end
end
