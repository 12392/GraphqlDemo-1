class Mutations::UpdateBook < Mutations::BaseMutation

    description "Update Book"

    argument :name, String
    argument :description, String
    argument :id, ID, required: true
  
    field :book, Types::BookType, null: false
    field :errors, [String], null: false

    #type Types::BookType

    def resolve(id:nil, name:nil, description:nil)

      unless context[:current_user].nil?
        author = context[:current_user]
        book = author.books.find(id)
        book.update_attributes(name: name, description: description)
        if(book.save)
          {book: book, errors: []}
        else
          {book: [], errors: book.errors.full_messages}
        end
      else
        raise GraphQL::ExecutionError, "Authentication failed, Sign in first"
      end
    end

end