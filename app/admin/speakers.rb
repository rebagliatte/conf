ActiveAdmin.register Speaker do
  menu parent: 'Talks'

  index do
    column :id
    column :name
    column :company
    column :city
    column :country
    column :twitter_username
    column :email
    actions
  end
end
