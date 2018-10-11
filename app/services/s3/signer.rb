# frozen_string_literal: true

module S3
  class Signer
    AVAILABLE_EXTENSIONS = %w[jpg jpeg png gif].freeze
    AVAILABLE_RESOURCES = %w[image proof_of_address document criminal].freeze

    SignedUploadConfig = Struct.new(:public_url, :fields)

    class UnknownExtensionError < StandardError; end
    class UnknownResourceError < StandardError; end

    include Helpers::FileHelper

    def initialize(options)
      @object_id = options[:object].id
      @object_type = options[:object].class.name.pluralize.downcase
      @resource_name = options[:resource_name]
      @file_name = options[:file_name]
    end

    def generate_signature
      check_resource!
      check_extension!

      post = generate_post
      SignedUploadConfig.new(post.url, post.fields)
    end

    private

    def check_extension!
      unless AVAILABLE_EXTENSIONS.include?(extension_for(@file_name))
        raise UnknownExtensionError,
              "Extensão não aceita! As extensões válidas são: #{AVAILABLE_EXTENSIONS.join(', ')}"
      end
    end

    def check_resource!
      unless AVAILABLE_RESOURCES.include?(@resource_name)
        raise UnknownResourceError,
              "Recurso desconhecido! Recursos disponíveis são: #{AVAILABLE_RESOURCES.join(', ')}"
      end
    end

    def generate_post
      signer
        .key(key)
        .acl('public-read')
        .success_action_status('201')
        .expires(5.minutes.from_now)
        .content_type(type_for(@file_name))
        .metadata('original-filename': @file_name)
    end

    def key
      "#{@resource_name}/#{@object_type}/#{@object_id}/#{mounted_file_name}"
    end

    def mounted_file_name
      "#{DateTime.now.strftime('%Y-%m-%d')}-#{name_for(@file_name)}-#{SecureRandom.urlsafe_base64}.#{extension_for(@file_name)}"
    end

    def signer
      creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])

      Aws::S3::PresignedPost.new(creds, ENV['AWS_REGION'], ENV['S3_BUCKET'])
    end
  end
end
