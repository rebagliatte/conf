namespace :onesies do
  task populate_slugs: :environment do
    ConferenceEdition.all.each do |ce|
      ce.save
    end
  end
end
