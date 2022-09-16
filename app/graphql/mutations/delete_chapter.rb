class Mutations::DeleteChapter < Mutations::BaseMutation

    description "delete Chapter"

    argument :id, ID, required: true
    argument :book_id, Integer, required: true
    type Types::ChapterType

    def resolve(id: nil, book_id: nil)

        unless context[:current_user].nil?
            author = context[:current_user]
            book = author.books.find(book_id)
            chapter = book.chapters.find(id)
            chapter.destroy!
          else
            raise GraphQL::ExecutionError, "Authentication failed, Sign in first"
          end
    
    end

end
