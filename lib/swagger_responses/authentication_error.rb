module SwaggerResponses
  module AuthenticationError
    def self.extended(base)
      base.response 401 do
        key :description, 'A request with no authenticated user'
        schema do
          property :errors do
            key :type, :array
            key :example, ['You need to sign in or sign up before continuing.']
          end
        end
      end
    end
  end
end