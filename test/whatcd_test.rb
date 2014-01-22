require_relative "test_helper"

test "with correct credentials" do
	client = WhatCD::Client.new ENV["WHATCD_USERNAME"], ENV["WHATCD_PASSWORD"]
	assert client.authenticated?
	
	# Fetching existing resources
	assert client.fetch(:user, :id => 28747).is_a? Hash

	# Fetching non-existing resources
	assert_raise(WhatCD::APIError) { client.fetch(:bogus, :id => 28747) }
end

test "with incorrect credentials" do
	assert_raise(WhatCD::AuthError) { WhatCD::Client.new "", "" }

	client = WhatCD::Client.new
	assert (not client.authenticated?)

	# Fetching existing resources
	assert_raise(WhatCD::AuthError) { client.fetch(:user, :id => 28747) }

	# Fetching non-existing resources
	assert_raise(WhatCD::AuthError) { client.fetch(:bogus, :id => 28747) }
end
