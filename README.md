# GLPI SDK for Ruby

[![Gem](https://img.shields.io/gem/v/glpi-sdk-ruby.svg)](https://rubygems.org/gems/glpi-sdk-ruby)
[![Gem](https://img.shields.io/gem/dt/glpi-sdk-ruby.svg)](https://rubygems.org/gems/glpi-sdk-ruby)

Ruby wrapper for [GLPI REST API](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'glpi-sdk-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:
	
	$ gem install glpi-sdk-ruby

## Usage

### [Init session](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#init-session)
A session object is mandatory to uses the others GLPI methods.

```ruby
require 'glpi/sdk'
	
# Request a session token to uses other GLPI functions

url = 'http://path/to/glpi/apirest.php'
app_token = 'YOUR_APP_TOKEN'
username = 'YOUR_GLPI_USERNAME'
password = 'YOUR_GLPI_PASSWORD'
    
session = GLPI::SDK::Session.new(url, app_token, username, password)
session.token
# => "74e735e494e9613ee50d13135df6d27d"
```

### [Kill session](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#kill-session)
```ruby
session.kill
```

### [Get active profile](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#get-active-profile)
```ruby
session.active_profile
```

### [Get active entities](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#get-active-entities)
```ruby
session.active_entities
```

### [Get full GLPI session](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#get-full-session)
```ruby
session.full_session
```

### [Get GLPI config](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#get-glpi-config)
```ruby
session.glpi_config
```

### [Get an item](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#get-an-item)
```ruby
ticket = GLPI::SDK::Resource.find(session, 1, 'Ticket')
ticket.id
# => 1

ticket.name
# => "Hello World"
```

### [Get all items](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#get-all-items)
```ruby
tickets = GLPI::SDK::Resource.all(session, item_type: 'Ticket')
```

### [Create an item](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#add-items)
```ruby
ticket = GLPI::SDK::Resource.create(
  session,
  name: 'New ticket from SDK',
  content: 'Ticket created by GLPI SDK',
  item_type: 'Ticket'
)

ticket.id
# => 29

ticket.content
# => "Ticket created by GLPI SDK"
```

### [Update an item](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#update-items)
```ruby
ticket = GLPI::SDK::Resource.update(
  session,
  29,
  content: 'Content updated by GLPI SDK',
  item_type: 'Ticket'
)

ticket.content
# => "Ticket updated by GLPI SDK"
```

### [Delete an item](https://github.com/glpi-project/glpi/blob/9.2/bugfixes/apirest.md#delete-items)
```ruby
GLPI::SDK::Resource.destroy(session, 29, 'Ticket')
# => true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/truly-systems/glpi-sdk-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GLPI::SDK::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/truly-systems/glpi-sdk-ruby/blob/master/CODE_OF_CONDUCT.md).
