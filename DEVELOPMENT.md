# Development Guide

## Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/davingee/Peripatetic.git
   cd Peripatetic
   ```

2. **Install Ruby dependencies**

   ```bash
   bundle install
   ```

3. **Setup the database** (for testing)
   ```bash
   bundle exec rake db:create
   bundle exec rake db:migrate
   ```

## Running Tests

Run the test suite with:

```bash
bundle exec rspec
# or
bundle exec rake spec
```

For detailed output:

```bash
bundle exec rspec --format documentation
```

## Code Quality

### RuboCop (Linting)

Check code style:

```bash
bundle exec rubocop
```

Auto-fix issues:

```bash
bundle exec rubocop -a
```

## Building the Gem

To build the gem locally:

```bash
gem build peripatetic.gemspec
```

This creates a `.gem` file that can be installed locally.

## Release Process

1. Update the version in `lib/peripatetic/version.rb`
2. Update `CHANGELOG.md`
3. Commit changes: `git commit -am "Release v1.x.x"`
4. Tag the release: `git tag v1.x.x`
5. Push to GitHub: `git push origin main && git push origin v1.x.x`
6. Build the gem: `gem build peripatetic.gemspec`
7. Push to RubyGems: `gem push peripatetic-1.x.x.gem`

## Documentation

Generate YARD documentation:

```bash
bundle exec yard
```

Documentation will be available in `doc/index.html`

## Structure

```
lib/
├── peripatetic.rb           # Main module
├── peripatetic/
│   ├── version.rb           # Version constant
│   ├── railtie.rb           # Rails integration
│   ├── location.rb          # Location model
│   ├── country.rb           # Country model
│   └── postal_code.rb       # PostalCode model
└── generators/
    └── peripatetic/
        ├── install_generator.rb  # Installation generator
        └── templates/            # Migration templates

test/
└── spec/
    ├── spec_helper.rb
    └── peripatetic_spec.rb

preparing/
├── countries.yaml           # Country data
├── free-zipcode-database-Primary.csv  # Postal code data
├── import_geonames.sh       # Import script
└── ...
```

## Common Tasks

### Add a New Model

1. Create the model file in `lib/peripatetic/`
2. Add tests in `test/spec/`
3. Document in README.md

### Add a Migration Template

1. Create the migration template in `lib/generators/peripatetic/templates/`
2. Update the install generator to copy it
3. Test with: `rails generate peripatetic:install`

### Update Dependencies

1. Edit `peripatetic.gemspec`
2. Run `bundle update`
3. Test thoroughly

## Troubleshooting

### Tests failing after dependency update

Try cleaning and reinstalling:

```bash
bundle clean --force
bundle install
```

### Gem installation fails

Check for conflicting gems:

```bash
gem list | grep peripatetic
gem uninstall peripatetic
```

## Questions?

Open an issue on [GitHub](https://github.com/davingee/Peripatetic/issues)
