require 'riot'
require 'whatcd'

username = ENV['WHATCD_USERNAME']
password = ENV['WHATCD_PASSWORD']

context WhatCD do 
	setup { WhatCD }

	asserts('includes HTTParty methods') { topic }.kind_of? HTTParty

	context 'Correct credentials' do
		hookup { WhatCD::authenticate username, password }

		asserts('is authenticated') { topic::authenticated? }
		asserts('can make requests') { topic::User(id: 28747) }.kind_of Hash
		asserts('raises exceptions') { topic::Gibberish }.raises NameError
	end

	context 'Incorrect credentials' do
		asserts { WhatCD::authenticate '.', '..' }.raises WhatCD::AuthError
	end
end
