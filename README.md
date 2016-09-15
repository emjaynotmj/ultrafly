## UltraFly

A flight booking application that allows users to make booking reservations. It can be viewed online [here](https://ultrafly.herokuapp.com)
## Getting Started
1. Clone the repository:
    ````
    $ git clone https://github.com/andela-ajamiu/ultrafly.git
    ````

2. Navigate into the cloned repository folder:
    ```
    $ cd ultrafly
    ```

3. Install dependencies:
    ```
    $ bundle install
    ```

4. Setup database:
    ```
    $ rake db:setup
    ```


## Usage
1. Start rails server
    ```
    $ rails s
    ```

2. Navigate to your browser and type in: http://localhost:3000

## External Dependencies/Gems

~ Rails Framework
~ Devise
~ Simple_Form
~ Faker
~ Cocoon
~ Puma Web Server
~ Rails_12factor
~ Letter_opener
~ Toastr-rails
~ RSpec-rails
~ Capybara
~ Factory_girls
~ Database_cleaner


## Running Tests

1. Make sure "rspec" is installed by running:
    ```sh
        $ bundle show rspec
    ```
    If a path is listed, then rspec is installed.

2. Run rspec for the spec folder through bundle:
    ```sh
        $ bundle exec rspec spec
    ```


## Features

1. Users can search for flights based on the following criteria: **flight date**, **destination airport**, **departure airport** and **number of passengers**
2. Users can book for available flights.
3. Registered Users can see their past booking History.
4. Instantly notifies users via email on successful flight booking.


## Limitations

1. Users can not make payment for their flight
2. Registered users can not edit or cancel their past bookings


## Contributing

1. Fork it: [Fork the ultrafly project](https://github.com/andela-ajamiu/ultrafly/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request