ALTER TABLE comments ADD COLUMN owner_id INT(11) NOT NULL, ADD INDEX (owner_id, created_at);
