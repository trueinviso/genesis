if Rails.env.production?
  require "shrine"
  require "shrine/storage/s3"

  s3_options = {
    access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region:            ENV['AWS_REGION'],
    bucket:            ENV['AWS_BUCKET']
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "cache", upload_options: {acl: "public-read"}, **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", upload_options: {acl: "public-read"}, **s3_options),
  }

  Shrine.plugin :activerecord
  Shrine.plugin :direct_upload
  Shrine.plugin :restore_cached_data
else
  require "shrine"
  require "shrine/storage/file_system"

  Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
  }

  Shrine.plugin :activerecord
  Shrine.plugin :direct_upload
  Shrine.plugin :cached_attachment_data # for forms
end
