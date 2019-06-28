module Mutations
	class BaseMutation < GraphQL::Schema::RelayClassicMutation
		object_class Types::BaseObject
		input_object_class Types::BaseInputObject
	end
end