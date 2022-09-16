module Mutations
    class SignInUser < BaseMutation
      null true
  
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
  
      field :token, String, null: true
      field :author, Types::AuthorType, null: true
  
      def resolve(credentials: nil)
        # basic validation
        return unless credentials
  
        user = Author.find_by email: credentials[:email]
  
        # ensures we have the correct user
        return unless user
        return unless user.authenticate(credentials[:password])
  
        # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")

        context[:session][:token] = token

        { author: user, token: token }
      end
    end
  end
  