require_relative 'post'

class PostRepository

  def all
    sql =' SELECT id, title, contents, views, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.contents = record['contents']
      post.views = record['views']

      posts << post
    end
    return posts 
  end

  
  # def find(id)
  #   sql = 'SELECT id, username FROM accounts WHERE id = $1;'
  #   sql_params = [id]

  #   result_set = DatabaseConnection.exec_params(sql, sql_params)
  #   record = result_set[0]

  #   account = Account.new
  #   account.id = record['id']
  #   account.username = record['username']

  #   return account
  # end


  # def create(account)
  #   sql = 'INSERT INTO accounts (username) VALUES ($1);'
  #   sql_params = [account.username]

  #   DatabaseConnection.exec_params(sql, sql_params)

  #   return nil
  # end

  # def delete(id)
  #   sql = 'DELETE FROM accounts WHERE id = $1;'
  #   sql_params = [id]

  #   DatabaseConnection.exec_params(sql, sql_params)
  # end
end