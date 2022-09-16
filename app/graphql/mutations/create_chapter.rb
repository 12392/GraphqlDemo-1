class Mutations::CreateChapter < Mutations::BaseMutation

    description "Create Chapter"

    argument :book_id, Integer, required: true
    argument :name, String, required: true
    argument :short_description, String, required: true
    
    type Types::ChapterType

    def resolve(name: nil, short_description: nil,book_id: nil)

        unless context[:current_user].nil?
            author = context[:current_user]
            book = author.books.find(book_id)
            book.chapters.create!(name: name, short_description: short_description, book_id: book_id)
          else
            raise GraphQL::ExecutionError, "Authentication failed, Sign in first"
        end
    
    end

end
