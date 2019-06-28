module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: false do
      description "Find user by ID"
      argument :id, ID, required: true
    end

    field :all_users, [UserType], null: true do
      description "Find all users"
    end

    def user(id:)
      User.find(id)
    end

    def all_users
      User.all
    end
  end
end
