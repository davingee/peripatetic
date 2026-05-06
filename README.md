# Peripatetic

Drop-in polymorphic location management for Rails models with geocoding support.

## Requirements

- Rails 8.0+
- Ruby 3.1+
- Geocoder gem

## Installation

Add to your Gemfile:

```ruby
gem 'peripatetic', github: 'davingee/Peripatetic'
```

Then run:

```bash
bundle install
rails generate peripatetic:install
rails db:migrate
```

## Usage

Include `Peripatetic` in any model:

```ruby
class User < ApplicationRecord
  include Peripatetic
end
```

This adds a polymorphic `has_many :locations` with nested attribute support.

### Forms

```erb
<%= form_with model: @user do |f| %>
  <%= f.fields_for :locations do |builder| %>
    <%= builder.text_field :street %>
    <%= builder.text_field :accessor_postal_code %>
    <%= builder.select :accessor_country, all_countries.map { |c| [c.name, c.name] } %>
    <%= builder.check_box :_destroy %> Remove
  <% end %>
  <%= f.submit %>
<% end %>
```

### Strong Parameters

```ruby
locations_attributes: [:id, :street, :accessor_postal_code, :accessor_country, :_destroy]
```

### Accessing Locations

```ruby
user.locations.each do |location|
  puts location.full_address
  puts "#{location.latitude}, #{location.longitude}"
end
```

## How It Works

When a location is saved:

1. Postal code is validated against the `peripatetic_postal_codes` table
2. City, region, country code, and time zone are filled in from the postal code record
3. If a street address is present, the geocoder refines the coordinates

## Development

```bash
bundle install
bundle exec rspec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes
4. Push to the branch and open a pull request

## License

MIT
