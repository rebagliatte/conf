namespace :onesies do
  task populate_slugs: :environment do
    Post.all.each do |p|
      p.save
    end
    Page.all.each do |p|
      p.save
    end
  end
end
