-- Add a users table.
-- Should track fname and lname attributes.
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

-- Add a questions table.
-- Track the title, the body, and the associated author (a foreign key).
CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);


-- Add a question_followers table.
-- This should support the many-to-many relationship between questions and users (a user can have many questions she is following, and a question can have many followers).
-- This is an example of a join table; the rows in question_followers are used to join users to questions and vice versa.
CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Add a replies table.
-- Each reply should contain a reference to the subject question.
-- Each reply should have a reference to its parent reply.
-- Each reply should have a reference to the user who wrote it.
-- Don't forget to keep track of the body of a reply.
-- "Top level" replies don't have any parent, but all replies have a subject question.
-- It's okay for a column to be self referential; a foreign key can point to a primary key in the same table.
CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,
  body VARCHAR(255) NOT NULL,
  FOREIGN KEY (subject_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)

);

-- Add a question_likes table.
-- Users can like a question.
-- Have references to the user and the question in this table
CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- You will probably also want to write some INSERT statements at the bottom of your
-- import_db.sql file, so that you have some data to play with.
-- We call this 'seeding the database.'
INSERT INTO
  users (fname, lname)
VALUES
  ('Albert', 'Einstein'),
  ('Kurt', 'Godel');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('how much wood', 'can a woodchuck chuck', (SELECT id FROM users WHERE lname = 'Einstein')),
  ('burrito microwaving', 'can god microwave a burrito so hot he cant eat it',
    (SELECT id FROM users WHERE lname = 'Godel'));

INSERT INTO
  replies (subject_id, parent_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'how much wood'), NULL,
   (SELECT id FROM users WHERE lname = 'Godel'), 'seven woods.');

INSERT INTO
  question_followers (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE lname = 'Godel'),
   (SELECT id FROM questions WHERE title = 'how much wood'));

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE lname = 'Godel'),
   (SELECT id FROM questions WHERE title = 'how much wood')), (2,2), (1,2);
