module Mutations
	class CreateUser < BaseMutation
		argument :name, String, required: true
		argument :password, String, required: true

		field :user, Types::UserType, null: true
		field :errors, [String], null: false

		def resolve(name:, password:)
			user = User.new(name: name, password: password)
			if user.save
				{
					user: user,
					errors: [],
				}
			else
				{
					user: nil,
					errors: user.errors.full_messages,
				}
			end
		end
	end
end