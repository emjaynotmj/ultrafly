## UltraFly <a href="https://codeclimate.com/github/andela-ajamiu/ultrafly"><img src="https://codeclimate.com/github/andela-ajamiu/ultrafly/badges/gpa.svg" /></a> </a><a href="https://codeclimate.com/github/andela-ajamiu/ultrafly"><img src="https://codeclimate.com/github/andela-ajamiu/ultrafly/badges/issue_count.svg" /></a><a href='https://coveralls.io/github/andela-ajamiu/ultrafly?branch=master'><img src='https://coveralls.io/repos/github/andela-ajamiu/ultrafly/badge.svg?branch=master' alt='Coverage Status' /></a>[![Build Status](https://travis-ci.org/andela-ajamiu/ultrafly.svg?branch=ch-corrections-131425913)](https://travis-ci.org/andela-ajamiu/ultrafly)[![CircleCI](https://circleci.com/gh/andela-ajamiu/ultrafly.svg?style=svg)](https://circleci.com/gh/andela-ajamiu/ultrafly)

A flight booking application that allows users to book for available flights. It can be viewed online [here](https://ultrafly.herokuapp.com)
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

~ Rails Framework<br>
~ Devise<br>
~ Simple_Form<br>
~ Faker<br>
~ Cocoon<br>
~ Puma Web Server<br>
~ Rails_12factor<br>
~ Letter_opener<br>
~ Toastr-rails<br>
~ RSpec-rails<br>
~ Capybara<br>
~ Factory_girls<br>
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
3. users can make payment for their bookings via PayPal.
4. Registered Users can see their past booking History.
5. Instantly notifies users via email on successful flight booking and record update.
6. Users can search for bookings based on their booking reference number.
7. Registered users can edit and update their booking records if the flight has not moved yet.
8. Registered users can edit their profile with name, phone number and gender.
9. registered users are prompted to make payment upon update of their booking records.
10. Users can see the listing of all available flights on the "All Flights" page.



## Contributing

1. Fork it: [Fork the ultrafly project](https://github.com/andela-ajamiu/ultrafly/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request