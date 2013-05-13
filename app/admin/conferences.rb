ActiveAdmin.register Conference do
  index do
    column :id
    column :name
    column :twitter_username
    column :twitter_hashtag
    actions
  end
end
