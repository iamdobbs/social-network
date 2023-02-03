require 'post_repository'

RSpec.describe PostRepository do

  def reset_posts_table
    seed_sql = File.read('spec/social_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_database' })
    connection.exec(seed_sql)
  end

  describe PostRepository do
    before(:each) do 
      reset_posts_table
    end
  end
end    