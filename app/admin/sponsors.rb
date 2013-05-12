ActiveAdmin.register Sponsor do
  form do |f|
    f.inputs 'Details' do
      f.input :conference_edition
      f.input :name
      f.input :description
      f.input :kind, as: :select, collection: Sponsor::KINDS, include_blank: false
      f.input :logo
    end
    f.actions
  end
end
