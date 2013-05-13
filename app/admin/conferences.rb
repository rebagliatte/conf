ActiveAdmin.register Conference do
  index do
    column :id
    column :subdomain
    column :name
    column :email
    column :twitter_username
    column :twitter_hashtag
    actions
  end
end
