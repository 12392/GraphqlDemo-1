class Mutations::UpdateBook < Mutations::BaseMutation

    description "Updates Book"

    argument :name, String
    argument :description, String
    argument :author_id, Integer
    argument :id, ID, required: true
  
    field :book, Types::BookType, null: false
    field :errors, [String], null: false

    def resolve(id:, name:, description:, author_id:)
        book = Book.find(id)
        book.update_attributes(name: name, description: description, author_id: author_id)
        if(book.save)
          {book: book, errors: []}
        else
          {book: [], errors: book.errors.full_messages}
        end
    end

end