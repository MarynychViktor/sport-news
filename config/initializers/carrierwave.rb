CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'Google',
    google_project: Rails.application.credentials.google_cloud_storage_project_name,
    google_json_key_string: Rails.application.credentials.google_cloud_storage_credential_content
  }
  config.fog_directory = Rails.application.credentials.google_cloud_storage_bucket_name
end

if Rails.env.test?  or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
  end
end
