class Mutations::UpdateChapter < Mutations::BaseMutation

    description "Update chapter"

    argument :name, String
    argument :short_description, String
    argument :id, ID, required: true
    argument :book_id, ID ,required: true
  
    field :chapter, Types::ChapterType, null: false
    field :errors, [String], null: false

    def resolve(id:nil, name:nil, short_description:nil , book_id: nil)

      unless context[:current_user].nil?
        author = context[:current_user]
        book = author.books.find(book_id)
        chapter = book.chapters.find(id)
        chapter.update_attributes(name: name, short_description: short_description)
        if(chapter.save)
          {chapter: chapter, errors: []}
        else
          {chapter: [], errors: chapter.errors.full_messages}
        end
      else
        raise GraphQL::ExecutionError, "Authentication failed, Sign in first"
      end
    end

end