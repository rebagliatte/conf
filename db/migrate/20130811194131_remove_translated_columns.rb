class RemoveTranslatedColumns < ActiveRecord::Migration
  def change
    # remove_columns :talks, :title
    # remove_columns :talks, :abstract
    remove_columns :posts, :title
    remove_columns :posts, :body
    remove_columns :posts, :summary
    remove_columns :speakers, :bio
    remove_columns :sponsors, :description
    remove_columns :conference_editions, :tagline
    remove_columns :conference_editions, :country
    remove_columns :conference_editions, :city
    remove_columns :conference_editions, :venue
  end
end
