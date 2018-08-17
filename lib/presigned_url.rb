require 'aws-sdk-s3'
require 'securerandom'

class PresignedUrl
  def self.generate
    # TODO: Consolidate AWS settings somewhere (oh look, Aws.config) and pull
    # only from those. Remove hardcoded strings like bucket names
    s3 = Aws::S3::Resource.new(region: 'us-east-2')
    obj = s3.bucket('pollencam-user-uploads').object(SecureRandom.uuid)
    obj.presigned_url(:put, expires_in: 3.days.to_i)
  end
end
