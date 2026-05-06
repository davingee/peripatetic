# Contributing to Peripatetic

We love contributions! Here's how you can help.

## Code of Conduct

Be respectful and constructive in all interactions.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/Peripatetic.git`
3. Create a branch: `git checkout -b feature/my-feature`
4. Follow the [Development Guide](DEVELOPMENT.md)

## Making Changes

1. Write tests for your feature or bug fix
2. Make your changes
3. Ensure all tests pass: `bundle exec rspec`
4. Ensure code style passes: `bundle exec rubocop`
5. Update documentation if needed

## Submitting Changes

1. Push to your fork
2. Create a Pull Request with a clear description
3. Reference any related issues
4. Ensure CI passes

## Coding Standards

- Use 2-space indentation
- Follow Ruby style guide recommendations
- Write descriptive commit messages
- Include tests for all features
- Update CHANGELOG.md

## Testing

All submissions must include tests:

```bash
# Run all tests
bundle exec rspec

# Run a specific test
bundle exec rspec test/spec/peripatetic_spec.rb

# Run with verbose output
bundle exec rspec --format documentation
```

## Questions?

Open an issue on [GitHub](https://github.com/davingee/Peripatetic/issues)
