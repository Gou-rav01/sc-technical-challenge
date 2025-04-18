# Client Store CLI

A Ruby command-line application for managing client data, supporting partial name searches (case-insensitive) and duplicate email detection.

## Setup Instructions

### Prerequisites
- **Ruby 3.4.3**: Specified in `.ruby-version` for compatibility.
- **Bundler**: Install with `gem install bundler` for dependency management.

### Installation
1. **Install Ruby 3.4.3**: Verify with
   ```bash
   ruby -v
   ```

2. **Clone the Project**:
   ```bash
   git clone https://github.com/Gou-rav01/sc-technical-challenge.git && cd ./sc-technical-challenge
   ```
3. **Install Dependencies**:
   ```bash
   bundle install
   ```
   This generates `Gemfile.lock` and installs gems (`rspec`, `rubocop`, `rubocop-rspec`, `simplecov`, `debug`).

4. **Make the CLI Executable**:
   ```bash
   chmod +x ./bin/client_store
   ```

## Usage Instructions

### Running the Application
1. Execute the CLI:
   ```bash
   ./bin/client_store
   ```
2. Follow the interactive menu:
   - **Option 1**: Search clients by name (partial, case-insensitive).
   - **Option 2**: Find duplicate emails in the dataset.
   - **Option 3**: Exit the application.

### Running Tests
Run RSpec tests with coverage:
```bash
bundle exec rspec
```

### Linting
Run RuboCop with RSpec extension for code style and test quality:
```bash
bundle exec rubocop
```

## Assumptions and Decisions Made

### Assumptions
- **Data Source**: The client data is provided in `sample_clients.json` in the project root, containing valid JSON with `id`, `full_name`, and `email` keys.
- **Input Validation**: The JSON file is expected to exist and be well-formed; errors (missing file, malformed JSON) are handled with user-friendly messages.
- **CLI Usage**: Users interact via a simple text-based menu, with input limited to menu choices and name queries.

### Design Decisions
- **Followed OOP Structure**:
  - `Client`: Encapsulates client data with a clean `to_s` representation.
  - `ClientModel`: Manages data operations (search, duplicates) with key validation.
  - `CommandLineInterface`: Holds CLI code i.e, user interactions.
- **Keyword Arguments**: Used in all over for explicit, order-independent parameter passing.
- **Includes Error Handling**:
  - `bin/client_store` catches `Errno::ENOENT` (missing file) and `JSON::ParserError` (malformed JSON), exiting gracefully.
  - `ClientModel` validates required JSON keys, raising `KeyError` for missing keys.
- **Testing**: Added RSpec with `simplecov` for code coverage, `rubocop-rspec` for test quality.
- **Linting**: Added Rubocop better code quality and consistency

## Known Limitations
- **Hardcoded Data Source**: The application relies on `sample_clients.json`. No support for dynamic data sources (e.g., APIs, databases).
- **Limited Validation**: `ClientModel` validates required keys but doesn’t check data types (e.g., `id` as integer) or email format validity.
- **Interactive Testing**: `CommandLineInterface` specs don’t test interactive methods (`start`, `search_clients`) due to STDIN/STDOUT complexity, relying on non-interactive method tests.

## Areas for Future Improvement
- **Dynamic Data Sources**: Add support for loading data from APIs, databases, or other file formats (e.g., CSV).
- **Enhanced Validation**: Validate data types (e.g., ensure `id` is an integer) and email formats.
- **User Experience**:
  - Add input sanitization for name queries (e.g., trim whitespace, handle special characters).
  - Enhance output formatting (e.g., tabular results instead of current list results).
