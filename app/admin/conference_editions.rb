ActiveAdmin.register ConferenceEdition do

  menu parent: 'Conferences'

  index do
    column :id
    column :conference
    column :from_date
    column :to_date
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :from_date
      f.input :to_date
      f.input :tagline
      f.input :kind, as: :select, collection: ConferenceEdition::KINDS, include_blank: false
      f.input :status, as: :select, collection: ConferenceEdition::STATUSES, include_blank: false
      f.input :country, as: :string
      f.input :city
      f.input :venue
      f.input :logo
      f.input :promo_image
      f.input :promo_video_provider
      f.input :promo_video_uid
    end
    f.actions
  end
end
