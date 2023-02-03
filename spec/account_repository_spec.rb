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

    it 'creates a new account record' do
      repo = AccountRepository.new

      account = Account.new
      account.username = 'makers'

      repo.create(account)

      account = repo.all
      last_account = account.last
      expect(last_account.username).to eq('makers')
    end  

    it 'delete and account record' do
      repo = AccountRepository.new

      repo.delete(1)

      accounts = repo.all
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to eq('2')
    end  

    it 'updates an account record' do

      repo = AccountRepository.new

      account = repo.find(1)
      account.username = 'woolydog'

      repo.update(account)

      updated_acc = repo.find(1)
      expect(updated_acc.username).to eq('woolydog')
    end  
  end
end