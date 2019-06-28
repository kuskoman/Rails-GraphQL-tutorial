module GraphQL
	module MutationVariables
		def mutation_variables(factory, input = {})
			attributes = attributes_for(factory)

			input.reverse_merge!(attributes)

			camelize_hash_keys(input).to_json
		end

		def camelize_hash_keys(hash)
			raise unless hash.is_a?(Hash)

			hash.transform_keys { |key| key.to_s.camelize(:lower) }
		end
	end
end