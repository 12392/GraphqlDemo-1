class Mutations::DeleteAuthor < Mutations::BaseMutation
    description "Delete Author"
  
    #argument :name, String, required: true
    argument :id, ID, required: true
  
    field :author, Types::AuthorType, null: false
    field :errors, [String], null: false
  
    def resolve(id:)
      author = Author.find(id)
      author.books.clear
      author.destroy!
  
      if(author.errors.blank?)
        {author: author, errors: []}
      else
        {author: [], errors: author.errors.full_messages}
      end
    end
  
end