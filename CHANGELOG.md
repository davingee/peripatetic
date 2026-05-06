# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024

### Added

- Rails 8.0+ support
- Modern generator system with `rails generate peripatetic:install`
- Comprehensive test suite with RSpec 6
- GitHub Actions CI/CD workflow
- Improved documentation and examples
- Modern hash syntax throughout
- Proper strong parameters support
- Validations for locations
- Better geocoding configuration
- Support for Ruby 3.1+

### Changed

- Replaced deprecated `attr_accessible` with strong parameters in controllers
- Updated to modern Rails association syntax (`:as =>` → `as:`)
- Improved Railtie implementation
- Updated all models to use `ApplicationRecord`
- Enhanced PostalCode model with proper validations
- Improved Location model with better geocoding workflow

### Fixed

- Railtie syntax error (`include, Peripatetic` → `include Peripatetic`)
- PostalCode lookup using deprecated method

### Removed

- Support for Rails versions below 8.0
- Deprecated attr_accessible declarations (use strong parameters)
- Old Cucumber dependencies

## [0.0.1] - Initial Release

### Added

- Initial gem release
- Basic location management
- Geocoding integration
- Postal code validation
