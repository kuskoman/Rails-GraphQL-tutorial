module Types
  class QueryType < Types::BaseObject
    field :user, UserType, null: false do
      description "Find user by ID"
      argument :id, ID, required: true
    end
  end

  def user(id:)
    User.find(id)
  end
end
