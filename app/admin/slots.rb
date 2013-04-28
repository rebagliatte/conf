ActiveAdmin.register Slot do
  menu parent: 'Talks'

  form do |f|
    f.inputs 'Details' do
      f.input :conference_edition
      f.input :from_datetime, label: 'From'
      f.input :to_datetime, to: 'To'
      f.input :kind, as: :select, collection: Slot::KINDS, include_blank: false
    end
    f.actions
  end
end
