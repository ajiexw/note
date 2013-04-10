CREATE USER note IDENTIFIED BY 'note_db_password';
GRANT ALL PRIVILEGES ON note.* TO note@'localhost' IDENTIFIED BY 'note_db_password';
GRANT ALL PRIVILEGES ON note_test.* TO note@'localhost' IDENTIFIED BY 'note_db_password';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS note;
CREATE DATABASE IF NOT EXISTS note_test;
