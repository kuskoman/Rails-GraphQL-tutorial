module Types
	class UserType < Types::BaseObject
		description "Just user, lol"
	  field :id, ID, null: false
	  field :name, String, null: false
	  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
	end
end