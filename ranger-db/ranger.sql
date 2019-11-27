CREATE USER 'admin'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'%' WITH GRANT OPTION;
CREATE USER 'ranger'@'%' IDENTIFIED BY 'password';
CREATE USER 'rangeradmin'@'%' IDENTIFIED BY 'password';
CREATE USER 'rangerlogger'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;