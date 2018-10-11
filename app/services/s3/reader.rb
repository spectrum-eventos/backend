# frozen_string_literal: true

require 'aws-sdk'

module S3
  class Reader
    EXPIRE_TIME = 5.minutes.to_i.freeze

    def initialize
      @bucket = Aws::S3::Bucket.new(ENV['S3_BUCKET'])
    end

    def generate_link(identifier)
      @bucket.object(identifier).presigned_url(:get, expires_in: EXPIRE_TIME, secure: true)
    end
  end
end
