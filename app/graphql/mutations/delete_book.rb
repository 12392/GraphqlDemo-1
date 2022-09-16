class Mutations::DeleteBook < Mutations::BaseMutation

    description "Delete Book"

    argument :id, ID, required: true
    type Types::BookType
    
    def resolve(id:)
      unless context[:current_user].nil?
        author = context[:current_user]
        book = author.books.find(id)
        book.chapters.clear
        book.destroy!
      else
        raise GraphQL::ExecutionError, "Authentication failed, Sign in first"
      end
    end

end