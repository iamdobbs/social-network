# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
**Please see social_design_schema file for table info**
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

**Seed data for both repositories included here**

```sql

TRUNCATE TABLE accounts, posts RESTART IDENTITY;

INSERT INTO accounts (username) VALUES ('davidjones');
INSERT INTO accounts (username) VALUES ('thisiscode');

INSERT INTO posts (title, contents, views, account_id) VALUES ('hello', 'hello world', 10, 1);
INSERT INTO posts (title, contents, views, account_id) VALUES ('twice', 'saying hello twice', 25, 2);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)
class Account
end

# Repository class
# (in lib/account_repository.rb)
class AccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)

class Account
  attr_accessor :id, :username
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username FROM accounts;

    # Returns an array of Account objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username FROM accounts WHERE id = $1;

    # Returns a single Account object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(account)
  # INSERT INTO accounts (username) VALUES ($1);
  # No return
  end

  def update(account)
    # UPDATE accounts SET username = $1 WHERE id = $2;
    # Returns nothing, just updates record
  end

  def delete(id)
  # DELETE FROM accounts WHERE id = $1;
  # Return nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all accounts

repo = AccountRepository.new

accounts = repo.all
accounts.length # =>  2
accounts.first.username # => 'davidjones'

# 2
# Get a single username

repo = AccountRepository.new

account = repo.find(1)
account.id # =>  1
account.username # =>  'davidjones'


# 3
# Create a new account record
repo = AccountRepository.new

account = Account.new
account.username = 'makers'

repo.create(account)

account = repo.all
last_account = account.last
last_account.username # => 'makers'

# 4
# Deletes an account record
repo = AccountRepository.new

repo.delete(1)

accounts = repo.all
accounts.length # => 1
accounts.first.id # => 2

# 5 
# Updates an account

repo = AccountRepository.new

account = repo.find(1)
account.username = 'woolydog'

repo.update(account)

updated_acc = repo.find(1)
updated_acc.username # => 'woolydog'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/account_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/social_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'accounts' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
