class Word < ActiveRecord::Base

	def self.get_words(query_string,query_length,query_method)
		# Finding Words with chars in query string
		return nil if query_string.nil?
		chars_in_query = query_string.downcase.chars.sort.uniq
		len = chars_in_query.length
		new_array = []
		for i in 0..len
			new_array[2*i + 1] = chars_in_query[i]
		end
		new_array.length.times do |i|
			if i%2 == 0
				new_array[i] = '%'
			end
		end
		candidate_words = self.where("sorted like ?", new_array.join).pluck(:text)
		# Checking if query length limit is applied
		if query_length.nil? || query_length.empty?
			new_candidates = candidate_words
		elsif query_length.to_i > 0
			new_candidates = []	
			candidate_words.each do |word|
				if query_method == "e" || query_method.nil? || query_method.empty?
					new_candidates << word if word.length == query_length.to_i
				elsif query_method == "lte"
					new_candidates << word if word.length <= query_length.to_i
				elsif query_method == "lt"
					new_candidates << word if word.length < query_length.to_i
				end		
			end
		else
			new_candidates = []
		end
		#byebug
		return new_candidates
	end

end
