require_relative 'account'

class AccountRepository

  def all
    sql =' SELECT id, username FROM accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    accounts = []

    result_set.each do |record|
      account = Account.new
      account.id = record['id']
      account.username = record['username']

      accounts << account
    end
    return accounts  
  end

  
  def find(id)
    sql = 'SELECT id, username FROM accounts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    account = Account.new
    account.id = record['id']
    account.username = record['username']

    return account
  end

  # # Add more methods below for each operation you'd like to implement.

  # def create(account)
  # # INSERT INTO accounts (username) VALUES ($1);
  # # No return
  # end

  # def update(account)
  #   # UPDATE accounts SET username = $1 WHERE id = $2;
  #   # Returns nothing, just updates record
  # end

  # def delete(id)
  # # DELETE FROM accounts WHERE id = $1;
  # # Return nothing
  # end
end