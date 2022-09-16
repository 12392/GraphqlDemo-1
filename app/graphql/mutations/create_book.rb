class Mutations::CreateBook < Mutations::BaseMutation

    description "Create Book"

    argument :name, String, required: true
    argument :description, String, required: true
    
    type Types::BookType

    def resolve(name: nil, description: nil)
        Book.create!(name: name, description: description, author: context[:current_user])
    end

end
