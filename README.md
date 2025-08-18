Project Status
✅ Setup done
✅ Models & relations implemented
✅ Custom error handling added
⚠️ Business logic partially working (tests failing for AssignDeviceToUser)




## Features

- **User authentication** with `has_secure_password`.
- **Devices management** with assignment and return logic.
- **Business logic services**:
    - `AssignDeviceToUser` – allows a user to assign a device to themselves,  
      raises custom errors if device is already assigned or used incorrectly.
    - `ReturnDeviceFromUser` – allows a user to return a device.
- **Custom error classes** under `app/errors/` to handle specific validation cases.
- **RSpec tests** for controllers, models and services (partially failing).

## Known Issues

- Some specs for `AssignDeviceToUser` service are still failing due to  
  mismatched service initialization (`ArgumentError: missing keyword :user`).
- Needs further refactoring to fully align with test suite expectations.

## How to Run

1. Ensure Ruby and Bundler are installed.  
   Recommended Ruby version: `3.2.x`

2. Install dependencies:
   ```bash
   bundle install
3. Prepare database
RAILS_ENV=development bin/rails db:setup
RAILS_ENV=test bin/rails db:drop db:create db:schema:load
4. Run the test suite
   bundle exec rspec


