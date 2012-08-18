# What is it?

**whatcd** is an API wrapper for [What.cd](http://what.cd)'s JSON API.

# Usage

First, authentication:

```ruby
require 'whatcd'

# Authentication
WhatCD::authenticate 'username', 'password'

# Or, alternatively, make clever use of HTTParty's features
WhatCD::cookies File.open('/tmp/cookie_file, 'rb').read
```

Once you're authenticated, you can start using the gem. It's fairly straigh-forward. It works as follows: `WhatCD::Action parameters_hash`. `Action` is one of the actions described in the API documentation (the xxx part in `\ajax.php?action=xxx`). **Make sure to capitalize this**. The `parameters_hash` is a regular hash, with `Symbol`s as keys. It represents the arguments.

```ruby
WhatCD::User :id => 666
# => { ... }

WhatCD::Browse :searchstr => 'The Flaming Lips'
# => { ... }

WhatCD::Rippy
# => Rippy is best viewed in Microsoft Internet Explorer 6.0
```

More documentation: http://rdoc.info/github/britishtea/whatcd.

# Installation

Just type `gem install whatcd` in your terminal. Or, when using Bundler:

```ruby
gem 'whatcd', :git => 'git://github.com/britishtea/whatcd.git'
```

# Changelog

## 0.1.0

- Initial stable version

# License - MIT License

Copyright (C) 2012 Paul Brickfeld

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.