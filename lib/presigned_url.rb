class PresignedUrl
  def self.generate
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    obj = s3.bucket('pollencam-user-uploads').object(SecureRandom.uuid)
    obj.presigned_url(:put, expires_in: 3.days.to_i)
  end
end
