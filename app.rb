require_relative 'lib/database_connection'
require_relative 'lib/account_repository'
require_relative 'lib/post_repository'

DatabaseConnection.connect('social_network_database')

sql = 'SELECT id, title, contents, account_id FROM posts;'
result = DatabaseConnection.exec_params('SELECT * FROM accounts;', [])
