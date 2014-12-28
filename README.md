# What is it?

**whatcd** is an API wrapper for [What.cd](http://what.cd)'s JSON API.

# Usage

Authentication can be done with a username and password or with cookies:

```ruby
require "whatcd"

client = WhatCD::Client.new "username", "password"

# or
client = WhatCD::Client.new
client.set_cookie "cookie value" 

client.fetch :user, :id => 28747
# => { "username" => "empeedrie", ... }
```

Documentation: http://rdoc.info/github/britishtea/whatcd.
What.CD API documentation: https://github.com/WhatCD/Gazelle/wiki/JSON-API-Documentation.

# Installation

`gem install whatcd`

# Changelog

- **0.2.0**: Full rewrite that works with Cloudflare.
- **0.1.5**: Access API over SSL only.
- **0.1.4**: Fix a bug that occured when requesting resources without 
parameters.
- **0.1.3**: Fix a bug that extends the validity of cookies.
- **0.1.2**: General maintenance.
- **0.1.1**: Introduce support for rippy.
- **0.1.0**: Initial version.

# License - MIT License

See the LICENSE file.
