namespace :update_dictionary do
	
	desc "Updates Dictionary With Words in 'words' file in root folder of APP"

	# Words added will be small case only

	task :update => :environment do
  	data = File.read("words").split("\n")
  	data.each do |word|
  		sorted_char_set = word.downcase.chars.uniq.sort.join
  		Word.create(text: word.downcase, sorted: sorted_char_set)
  	end
  end

end
