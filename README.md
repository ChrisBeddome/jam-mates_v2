## About

Rails API backend for Jam Mates application.


## Setup

  

#### Prerequisites

  

The setups steps expect following tools installed on the system.

  

- [Git](https://git-scm.com/)

- Ruby [2.7.0](https://ruby-doc.org/core-2.7.0/)

 - Rails [6.1.3](https://rubygems.org/gems/rails/versions/6.1.3)

 - [MySQL](https://www.mysql.com/)
 

#### 1. Check out the repository

  

```bash

git clone git@github.com:ChrisBeddome/jam-mates_v2.git

```

  

#### 2. Run Bundle

  Run bundle to install project dependencies

```bash

cd ./jam-mates_v2
bundle

```

  

#### 3. Create MySQL users and grant necessary privileges

When creating the database, rails expects a test and dev user exist within the database.
  

```sql

CREATE USER 'jam_mates_test_user'@'localhost' IDENTIFIED BY  'jam_mates_test_password';
CREATE USER 'jam_mates_dev_user'@'localhost' IDENTIFIED BY  'jam_mates_dev_password';

GRANT ALL PRIVILEGES ON jam_mates_test.* TO  'jam_mates_test_user'@'localhost';
GRANT ALL PRIVILEGES ON jam_mates_dev.* TO  'jam_mates_dev_user'@'localhost';

```

#### 4. Create .env file in the root application directory with DB and user configs

Be sure to use the same usernames and passwords when used in the previous step

```

DB_TEST = "jam_mates_test"
DB_USER_TEST = 'jam_mates_test_user'
DB_PASSWORD_TEST = 'jam_mates_test_password'

DB_DEV = "jam_mates_dev"
DB_USER_DEV = 'jam_mates_dev_user'
DB_PASSWORD_DEV = 'jam_mates_dev_password'

```

#### 5. Create the database

Run the following commands to create and seed the database.

  

```ruby

rails  db:create
rails  db:seed

```  

#### 6. Start the Rails server

  

You can start the rails server using the command given below.

  

```ruby

rails s

```

  

## Testing

  

Jam Mates uses [RSpec](http://rspec.info/) as its testing framework.

  

To run the full suite, use the `bin/rspec` command

  

## Authentication

  

## End Points