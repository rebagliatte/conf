CarrierWave.configure do |config|
  config.s3_access_key_id = CONFIG[:aws_access_key_id]
  config.s3_secret_access_key = CONFIG[:aws_secret_access_key]
  config.s3_bucket = CONFIG[:aws_s3_bucket]
end
