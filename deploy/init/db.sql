CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100)
);

INSERT IGNORE INTO users (username, email) VALUES
  ('admin', 'admin@parspec.io'),
  ('demo', 'demo@parspec.io');
