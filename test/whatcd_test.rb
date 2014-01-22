require_relative "test_helper"

test "with correct credentials" do
	client = WhatCD::Client.new ENV["WHATCD_USERNAME"], ENV["WHATCD_PASSWORD"]
	assert client.authenticated?
	
	# Fetching existing resources
	assert_equal client.fetch(:user, :id => 28747).class, Hash

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

test "with a cookie" do
	client = WhatCD::Client.new
	assert (not client.authenticated?)

	client.set_cookie ENV["WHATCD_COOKIE"]

	assert_equal client.fetch(:user, :id => 28747).class, Hash
end
