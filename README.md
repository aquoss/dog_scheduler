## Instructions

Your assignment is to create a RESTful API to manage a dog's daily schedule.

At the bare minimum, this service should be able to:
- Schedule mealtimes for a dog
- Schedule walks for a dog
- Retrieve a dog's schedule for a particular day in JSON format

One important piece of business logic is that a dog cannot be doing multiple activities at the same time.

Do not worry about:
- Having different users or permissions
- Time zones, it is perfectly fine to assume all dogs live in the same time zone, or even in UTC

First and foremost, we will be looking for correctness. We will also pay attention to code clarity, unit tests, as well as your git commit history.

## Setting up

1. Install the required gems: `bundle install`
2. Set up test database: `rake db:test:prepare`
3. Run example tests: `rspec`
4. Set up your development database: `rake db:migrate`
5. (Optional) Seed your development database with an example Dog: `rake db:seed`

## Provided example code

We've put in some effort to make it easy to get started. There is already a Dog model and some example controller code to create a Dog. A good starting point would be to read through the provided integration spec in `/spec/integration/schedule_api_spec.rb`. You should definitely be modifying and adding to this file as you build out your solution.
