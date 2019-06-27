require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

	it 'has a valid factory' do
		expect(user).to be_valid
	end

	describe 'validation' do
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:password) }

		it { should validate_length_of(:name).is_at_least(3).is_at_most(32) }
		it { should validate_length_of(:password).is_at_least(6) }

		context 'username validation' do
			it 'should accept valid usernames' do
				valid_usernames = ['fqewqf', 'fFA-Ef231', 'Randy.Lahey', 'jrock_1337', '123-4_2.34235']

				valid_usernames.each do |username|
					user.name = username

					expect(user).to be_valid
				end
			end

			it 'should not accept invalid usernames' do
				invalid_usernames = ['!@3', 'ff ff', '...', 'dd@dd.pl', 'wqre2123-23-', '-EW213123ed_d',
					'', '---', 'pozdro_.dla-_wykopu']

				invalid_usernames.each do |username|
					user.name = username

					expect(user).to be_invalid
				end
			end
		end
	end
end