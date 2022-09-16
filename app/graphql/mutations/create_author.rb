class Mutations::CreateAuthor < Mutations::BaseMutation
    description "Create Author"

    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end
    
    argument :name, String, required: true
    argument :auth_provider,AuthProviderSignupData, required: false

    type Types::AuthorType
    
    
    def resolve(name: nil, auth_provider: nil)
      
      Author.create!(
        name: name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
      #Error handiling
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input xyx: #{e.record.errors.full_messages.join(', ')}")
    end
end