# Peripatetic Configuration

# Configure Geocoder gem integration
Geocoder.configure(
  # API key for geocoding service (if required)
  # api_key: ENV['GEOCODER_API_KEY'],

  # Timeout for geocoding requests (in seconds)
  timeout: 3,

  # Use Rails cache for geocoding results
  cache: Rails.cache,

  # Cache expiration time (24 hours)
  cache_options: { expires_in: 24.hours },

  # Units for distance calculations (:miles or :km)
  units: :miles,

  # HTTP user agent
  user_agent: "peripatetic-rails-gem"
)

# Peripatetic-specific configuration (optional)
module Peripatetic
  # Add your custom configuration here
  # Example:
  # ALLOWED_COUNTRIES = ['US', 'CA', 'MX']
end
