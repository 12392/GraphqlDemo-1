# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :name, String, null: true
    field :book_count, Integer, null: false
    field :books, [Types::BookType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def book_count
      object.books.count
    end
  end
end
