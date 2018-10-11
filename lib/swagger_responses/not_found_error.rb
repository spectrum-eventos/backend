module SwaggerResponses
  module NotFoundError
    def self.extended(base)
      base.response 404 do
        key :description, 'The requested resource was not found'
        schema do
          property :success do
            key :type, :boolean
            key :example, false
          end
          property :errors do
            key :type, :array
            items do
              key :type, :string
              key :example, 'Not found'
            end
          end
        end
      end
    end
  end
end