# README

## About

Rails API backend for Jam Mates application.

## Setup

#### Prerequisites

The setups steps expect following tools installed on the system.

- Git
- Ruby [2.7.0]
- Rails [6.1.3]
- MySQL

#### 1. Check out the repository

```bash
git clone git@github.com:ChrisBeddome/jam-mates_v2.git
```

#### 2. Run Bundle

```bash
cd ./jam-mates_v2
bundle
```

#### 3. Create MySQL users and grant necessary privilages

```sql
mysql> CREATE USER 'jam_mates_test_user'@'localhost' IDENTIFIED BY 'jam_mates_test_password';
mysql> CREATE USER 'jam_mates_dev_user'@'localhost' IDENTIFIED BY 'jam_mates_dev_password';

mysq> GRANT ALL PRIVILEGES ON jam_mates_test.*  TO 'jam_mates_test_user'@'localhost';
mysq> GRANT ALL PRIVILEGES ON jam_mates_development.*  TO 'jam_mates_dev_user'@'localhost';
```

#### 4. Create .env file in the root application directory with DB and user configs

```
DB_TEST = "jam_mates_test"
DB_USER_TEST = 'jam_mates_test_user'
DB_PASSWORD_TEST = 'jam_mates_test_password'

DB_DEV = "jam_mates_development"
DB_USER_DEV = 'jam_mates_dev_user'
DB_PASSWORD_DEV = 'jam_mates_dev_password'
```

#### 5. Create and setup the database

Run the following command to create and setup the database.

```ruby
rails db:create
```

#### 6. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

## Authentication

## End Points