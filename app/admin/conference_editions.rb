ActiveAdmin.register ConferenceEdition do
  form do |f|
    f.inputs 'Details' do
      f.input :conference_year, label: 'Year'
      f.input :description
      f.input :kind, as: :select, collection: ConferenceEdition::KINDS, include_blank: false
      f.input :status, as: :select, collection: ConferenceEdition::STATUSES, include_blank: false
      f.input :country, as: :string
      f.input :city
      f.input :venue
      f.input :promo_video_provider
      f.input :promo_video_uid
    end
    f.actions
  end
end
