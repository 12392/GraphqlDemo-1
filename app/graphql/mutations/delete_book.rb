class Mutations::DeleteBook < Mutations::BaseMutation

    description "Delete Book"

    argument :id, ID, required: true
  
    field :book, Types::BookType, null: false
    field :errors, [String], null: false

    def resolve(id:)
        book = Book.find(id)
        book.chapters.clear
        book.destroy!
        if(book.errors.blank?)
          {book: book, errors: []}
        else
          {book: [], errors: book.errors.full_messages}
        end
    end

end