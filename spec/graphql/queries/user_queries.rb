require 'rails_helper'

RSpec.describe 'user queries', type: :request do
	describe 'user(:id)' do
	end
	describe 'user login' do
		before do
			User.create!(user_params)

			post('/graphql', params: {
			 query: login_mutation,
			 variables: { email: input_params[:email], password: input_params[:password]}
			})
		end

		context 'valid params' do
			let(:user_params) { attributes_for(:user) }
			let(:input_params) { user_params }

			it 'returns no errors' do
				errors = json["data"]["login"]["errors"]
				expect(errors).to eq([])
			end

			it 'returns token' do
				token = json["data"]["login"]["token"]
				expect(token).not_to be_empty
			end
		end

		context 'invalid params' do
			let(:user_params) { attributes_for(:user) }
			let(:input_params) { { email: user_params[:email], password: "arandompassword" } }

			it 'returns errors' do
				errors = json["data"]["login"]["errors"]
				expect(errors).to eq(["Wrong password or email"])
			end

			it 'does not return token' do
				token = json["data"]["login"]["token"]
				expect(token).to be_nil
			end
		end	
	end
end