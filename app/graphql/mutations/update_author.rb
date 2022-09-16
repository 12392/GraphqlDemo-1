class Mutations::UpdateAuthor < Mutations::BaseMutation
    description "Updates Author"
  
    argument :name, String, required: true
    argument :email, String
  
    field :author, Types::AuthorType, null: false
    field :errors, [String], null: false
  
    def resolve(name:nil ,email: nil)
      
      unless context[:current_user].nil?
        author = context[:current_user]
        author = Author.find(author.id)
        author.update_attributes(name: name ,email: email)
        
        if(author.errors.blank?)
          {author: author, errors: []}
        else
        {author: [], errors: author.errors.full_messages}
      end
    else
      raise GraphQL::ExecutionError, "Authentication failed, you must be signed in!"
    end
    end
  
end