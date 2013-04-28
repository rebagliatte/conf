ActiveAdmin.register Talk do
  form do |f|
    f.inputs 'Details' do
      f.input :slot
      f.input :room
      f.input :title
      f.input :description
      f.input :status, as: :select, collection: Talk::STATUSES, include_blank: false
      f.input :slides_url
      f.input :video_url
    end
    f.actions
  end
end
