require 'rails_helper'

RSpec.describe 'createUser mutation', type: :request do
	describe 'user creation' do
		before do
			post('/graphql', params: {
			  query: %(
					mutation CreateUser(
						$name: String!,
						$password: String!,
					) {
						createUser(input: {
							name:$name,
							password:$password,
						}) {
							user {
								id
								name
							}
							errors,
						}
					}
				),
			  variables: mutation_variables(:user, input_variables)
			})
		end

		context 'when input is valid' do
			let(:user_attrs) { attributes_for(:user) }
			let(:input_variables) { user_attrs }

			it 'returns no errors' do
				errors = json["data"]["createUser"]["errors"]
				expect(errors).to eq([])
			end

			it 'returns username' do
				user_name = json["data"]["createUser"]["user"]["name"]
				expect(user_name).to eq(user_attrs[:name])
			end
		end

		context 'when input is invalid' do
			context 'when username is empty' do
				let(:input_variables) { {"name": ""} }

				it 'returns errors' do
					errors = json["data"]["createUser"]["errors"]
					expect(errors).not_to be_empty
				end

				it 'does not return user' do
					user = json["data"]["createUser"]["user"]
					expect(user).to be_nil
				end
			end

			context 'when password is invalid' do
				let(:input_variables) { {"password": "d"} }

				it 'returns errors' do
					errors = json["data"]["createUser"]["errors"]
					expect(errors).not_to be_empty
				end

				it 'does not return user' do
					user = json["data"]["createUser"]["user"]
					expect(user).to be_nil
				end
			end
		end
	end
end