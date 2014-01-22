# What is it?

**whatcd** is an API wrapper for [What.cd](http://what.cd)'s JSON API.

# Usage

First, authentication:

```ruby
require "whatcd"

client = WhatCD::Client.new "username", "password"

client.fetch :user, :id => 28747
# => { "username" => "empeedrie", ... }
```

Documentation: http://rdoc.info/github/britishtea/whatcd.

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

Copyright (C) 2012 Paul Brickfeld

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.