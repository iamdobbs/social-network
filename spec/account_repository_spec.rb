require 'account_repository'

RSpec.describe AccountRepository do
  
  def reset_accounts_table
    seed_sql = File.read('spec/social_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_database' })
    connection.exec(seed_sql)
  end
  
  describe AccountRepository do
    before(:each) do 
      reset_accounts_table
    end
  
    it 'returns a list of accounts' do
      repo = AccountRepository.new

      accounts = repo.all
      expect(accounts.length).to eq(2)
      expect(accounts.first.username).to eq('davidjones')
    end  
    
    it 'finds an account record' do
      repo = AccountRepository.new

      account = repo.find(1)
      expect(account.id).to eq('1')
      expect(account.username).to eq('davidjones')
    end

      # # 3
      # # Create a new account record
      # repo = AccountRepository.new

      # account = Account.new
      # account.username = 'makers'

      # repo.create(account)

      # account = repo.all
      # last_account = account.last
      # last_account.username # => 'makers'

      # # 4
      # # Deletes an account record
      # repo = AccountRepository.new

      # repo.delete(1)

      # accounts = repo.all
      # accounts.length # => 1
      # accounts.first.id # => 2

      # # 5 
      # # Updates an account

      # repo = AccountRepository.new

      # account = repo.find(1)
      # account.username = 'woolydog'

      # repo.update(account)

      # updated_acc = repo.find(1)
      # updated_acc.username # => 'woolydog'
  end
end