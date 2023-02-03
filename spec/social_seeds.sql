TRUNCATE TABLE accounts, posts RESTART IDENTITY;

INSERT INTO accounts (username) VALUES ('davidjones');
INSERT INTO accounts (username) VALUES ('thisiscode');

INSERT INTO posts (title, contents, views, account_id) VALUES ('hello', 'hello world', 10, 1);
INSERT INTO posts (title, contents, views, account_id) VALUES ('twice', 'saying hello twice', 25, 2);


