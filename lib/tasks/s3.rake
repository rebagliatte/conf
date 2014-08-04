namespace :s3 do
  STAGING_BUCKET = 'confnu-staging'
  PRODUCTION_BUCKET = 'confnu-production'
  my_bucket  = Rails.application.secrets.aws_s3_bucket

  yml_file   = File.read(File.join(Rails.root, 'config', 'secrets.yml'))
  s3_options = {
    access_key_id: Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key
  }

  s3 = AWS::S3.new(s3_options)

  desc 'Creates bucket for developer and syncs it with production'
  task :create_development_bucket => :environment do
    if !s3.buckets[my_bucket].exists? && s3.buckets.create(my_bucket)
      puts "Your bucket was created, getting a fresh copying production's bucket into it"
      source = s3.buckets[PRODUCTION_BUCKET]
      target = s3.buckets[my_bucket]
      copy_bucket(source,target, {acl: :public_read})
      puts 'All set!'
    else
      puts 'Bucket already exists'.red
    end
  end

  desc 'Sync staging bucket with production'
  task :sync_staging_bucket => :environment do |t, args|
    source = s3.buckets[PRODUCTION_BUCKET]
    target = s3.buckets[STAGING_BUCKET]

    copy_bucket(source,target, {acl: :public_read})
  end

  desc 'Sync development bucket with production bucket'
  task :sync_development_bucket => :environment do |t, args|
    source = s3.buckets[PRODUCTION_BUCKET]
    target = s3.buckets[my_bucket]

    copy_bucket(source,target, {acl: :public_read})
  end

  desc 'Copy content from bucket A to bucket B'
  task :copy_bucket, [:source, :target, :acl, :start_index ] => :environment do |t, args|
    opts = { acl: args.acl.try(:to_sym), start_index: args.start_index }

    copy_bucket(s3.buckets[args.source],s3.buckets[args.target], opts)
  end

  private

  def copy_bucket(source, target, opts = {})
    check_bucket(source)
    check_bucket(target)

    acl = opts[:acl] || :private
    start_idx = opts[:start_index] || 0
    objects = source.objects

    puts "Copying from #{source.name} to #{target.name}..."

    #S3 Objects don't work like an array
    objects.each_with_index do |obj, idx|
      if idx >= start_idx && !target.objects[obj.key].exists?
        puts "Storing #{idx} of #{objects.count} objects to #{target.name}..." if idx % 100 == 0
        target.objects[obj.key].copy_from(obj, {acl: acl})
      end
    end

    puts "\nYou're all set!"
  end

  def check_bucket(bucket)
    unless bucket.exists?
      puts "Bucket #{bucket.name} doesn't exists"
      exit
    end
  end
end
