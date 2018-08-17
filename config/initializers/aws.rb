require 'aws-sdk-s3'

if Rails.env.test?
  Aws.config.update(
    credentials: Aws::Credentials.new('THIS_IS_A_FAKE_ACCESS_KEY', 'THIS_IS_A_FAKE_SECRET_ACCESS_KEY_ID')
  )
end
