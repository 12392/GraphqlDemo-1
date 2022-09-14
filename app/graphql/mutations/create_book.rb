class Mutations::CreateBook < Mutations::BaseMutation

    description "Creates Book"

    argument :name, String
    argument :description, String
    argument :author_id, Integer
  
    field :book, Types::BookType, null: false
    field :errors, [String], null: false

    def resolve(name:, description:, author_id:)
        book = Book.new(name: name, description: description, author_id: author_id)
        if(book.save)
          {book: book, errors: []}
        else
          {book: [], errors: book.errors.full_messages}
        end
    end

end
