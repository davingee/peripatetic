# Peripatetic

A flexible location management gem for Rails that adds geocoding and location handling to any ActiveRecord model.

## Features

- **Polymorphic Locations**: Add locations to any model with a simple `include`
- **Geocoding Integration**: Built-in support for location geocoding via the `geocoder` gem
- **Nested Forms**: Easy integration with Rails form helpers for managing locations
- **Postal Code Validation**: Validate against a database of postal codes
- **Rails 8+ Compatible**: Fully updated for modern Rails versions

## Requirements

- Rails 8.0+
- Ruby 3.1+
- ActiveRecord
- Geocoder gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'peripatetic'
```

Then execute:

```bash
bundle install
```

## Usage

### Basic Setup

Include `Peripatetic` in any model that should have locations:

```ruby
class User < ApplicationRecord
  include Peripatetic
end
```

Or use the class method:

```ruby
class Organization < ApplicationRecord
  has_peripatetic_locations
end
```

### Database Setup

Run the Peripatetic generators to create the necessary tables:

```bash
rails generate peripatetic:install
rails db:migrate
```

This creates:

- `locations` table (polymorphic)
- `peripatetic_countries` table
- `peripatetic_postal_codes` table

### Using in Forms

In your form view, nest the location fields:

```erb
<%= form_with model: @user, local: true do |f| %>
  <%= f.fields_for :locations do |builder| %>
    <div class="field">
      <%= builder.label :street %>
      <%= builder.text_field :street %>
    </div>

    <div class="field">
      <%= builder.label :accessor_postal_code, "Postal Code" %>
      <%= builder.text_field :accessor_postal_code %>
    </div>

    <div class="field">
      <%= builder.label :accessor_country, "Country" %>
      <%= builder.select :accessor_country, countries_list %>
    </div>

    <div class="field">
      <%= builder.label :_destroy, "Remove" %>
      <%= builder.check_box :_destroy %>
    </div>
  <% end %>
  <%= f.submit %>
<% end %>
```

### Controller Strong Parameters

Permit location attributes in your controller:

```ruby
def user_params
  params.require(:user).permit(
    :name,
    :email,
    locations_attributes: [
      :id,
      :street,
      :accessor_postal_code,
      :accessor_country,
      :_destroy
    ]
  )
end
```

### Accessing Locations

```ruby
@user = User.find(1)
@user.locations.each do |location|
  puts location.street
  puts location.city
  puts location.region
  puts "#{location.latitude}, #{location.longitude}"
end
```

## Configuration

Customize geocoding behavior by configuring the Geocoder gem:

```ruby
# config/initializers/peripatetic.rb
Geocoder.configure(
  timeout: 3,
  cache: Rails.cache
)
```

## Models

### Location

The `Peripatetic::Location` model represents a location with:

- `street` - Street address
- `city` - City name
- `region` - State/Province/Region
- `postal_code` - Zip/Postal code
- `country_id` - Reference to country
- `latitude`, `longitude` - Geocoded coordinates
- `time_zone` - Associated time zone
- `geocoded` - Boolean flag for geocoded status

### Country

The `Peripatetic::Country` model stores country information with:

- `name` - Country name
- `alpha2` - ISO 3166-1 alpha-2 code

### PostalCode

The `Peripatetic::PostalCode` model provides postal code lookup with:

- `postal_code` - The postal/zip code
- `country_code` - Country code
- `city` - Associated city
- `region` - Associated state/province
- `latitude`, `longitude` - Geocoded coordinates
- `time_zone` - Associated time zone

## Validations

Location validations are automatically included:

- Validates postal code format against the postal code database
- Validates postal code exists for the selected country

## Geocoding

Locations are automatically geocoded when:

- A street address is added
- After validation if coordinates are needed

Reverse geocoding is available to get address details from coordinates.

## Importing Data

The `preparing/` directory contains scripts for importing country and postal code data.

**Example**: Import US postal codes:

```bash
cd preparing
ruby import_geonames.sh
ruby import_postal_codes.rb
```

## Development

### Setup

```bash
bundle install
rake spec
```

### Testing

```bash
rake spec
```

Tests use RSpec and are located in `test/spec/`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davingee/Peripatetic.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the MIT License.
