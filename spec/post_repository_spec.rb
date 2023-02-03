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


      # # 2
      # # Get a single post record

      # repo = PostRepository.new

      # post = repo.find(1)

      # post.id # =>  1
      # post.title # =>  'hello'
      # post.contents # =>  'hello world'

      # # 3
      # # Create new post

      # repo = PostRepostiory.new
      # post = Post.new
      # post.title = 'Created'
      # post.contents = 'For tests'
      # post.account_id = 2

      # repo.create(post) 

      # last_post = post.last
      # last_post.title # => 'Created'
      # last_post.contents # => 'For tests'
      # las_post.account_id # => 2

      # # 4
      # # Delete post

      # repo = PostRepository.new

      # repo.delete(1)

      # posts = repo.all
      # posts.length # => 1
      # posts.first.id # => 2
  end
end    