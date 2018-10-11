# frozen_string_literal: true

module S3
  module Helpers
    module FileHelper
      def extension_for(file_name)
        File.extname(file_name)[1..-1].downcase
      end

      def name_for(file_name)
        File.basename(file_name, File.extname(file_name)).downcase.gsub(/\s+/, '_')
      end

      def type_for(file_name)
        Mime::Type.lookup_by_extension(extension_for(file_name)).to_s
      end
    end
  end
end
