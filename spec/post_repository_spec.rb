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

    it 'return all post records' do
      repo = PostRepository.new

      posts = repo.all
      expect(posts.length).to eq(2)
      expect(posts.first.id).to eq('1')
      expect(posts.first.title).to eq('hello')
      expect(posts.first.contents).to eq('hello world')
      expect(posts.first.views).to eq('10')
    end  

    it 'gets a single post record' do
      repo = PostRepository.new

      post = repo.find(1)

      expect(post.id).to eq('1')
      expect(post.title).to eq('hello')
      expect(post.contents).to eq('hello world')
    end  

    it 'creates a new post' do

      repo = PostRepository.new
      post = Post.new
      post.title = 'Created'
      post.contents = 'For tests'
      post.views = '100'
      post.account_id = '2'

      repo.create(post) 

      last_post = repo.find(3)
      expect(last_post.title).to eq('Created')
      expect(last_post.contents).to eq('For tests')
      expect(last_post.views).to eq('100')
      expect(last_post.account_id).to eq('2')
    end  

    it 'delete a record' do

      repo = PostRepository.new

      repo.delete(1)

      posts = repo.all
      expect(posts.length).to eq(1)
      expect(posts.first.id).to eq('2')
    end  
  end
end    