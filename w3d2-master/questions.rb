require 'sqlite3'
require 'singleton'

class QuestionDatabase < SQLite3::Database
  include Singleton

  def initialize
    super ('questions.db')

    self.results_as_hash = true
    self.type_translation = true
  end
end


module TableSave
  def save
    if self.class == Reply
      c = 'replies'
    else
      c = self.class.to_s.downcase + 's'
    end

    vars = self.instance_variables.map! {|var| var.to_s.gsub('@','').to_sym}
    if self.id.nil?
      vars.shift
      QuestionDatabase.instance.execute(<<-SQL)
      INSERT INTO
        #{c + '(' + vars.join(',') + ')'}
      VALUES
        #{'(' + vars.map { |var| self.send(var).inspect }.join(', ') + ')'}
      SQL
    else
      QuestionDatabase.instance.execute(<<-SQL)
      UPDATE
        #{c}
      SET
        #{vars.map {|var| var.to_s + '=' + self.send(var).inspect}.join(',')}
      WHERE
        id = #{self.id}
      SQL
    end
  end
end

class User
  include TableSave

  def initialize(options = {})
    @id = options['id']
    @lname = options['lname']
    @fname = options['fname']
    save
  end

  attr_accessor :id, :lname, :fname

  def self.find_by_id(id)
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    results.map { |result| User.new(result) }[0]
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL

    results.map { |result| User.new(result) }[0]
  end


  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionFollower.liked_questions_for_user_id(id)
  end

  def average_karma
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      CAST(COUNT(DISTINCT question_likes.id) AS FLOAT)/COUNT(DISTINCT questions.id)
    FROM
      question_likes
    LEFT OUTER JOIN
      questions ON question_likes.question_id = questions.id
    WHERE
      questions.author_id = ?
    SQL
    results[0].values.first
  end
end

class Question
  include TableSave

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
    save
  end

  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.find_by_author_id(author_id)
    results = QuestionDatabse.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def author
    User.find_by_author_id(author_id)
  end

  def followers
    QuestionFollower.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

end

class QuestionFollower
  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_followers
    WHERE
      id = ?
    SQL

    results.map { |result| QuestionFollower.new(result) }
  end

  def self.followers_for_question_id(question_id)
    results = QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      question_followers
    JOIN
      users ON users.id = user_id
    WHERE
      question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      question_followers
    JOIN
      questions ON questions.id = question_id
    WHERE
      user_id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      question_followers
    JOIN
      questions ON questions.id = question_id
    GROUP BY
      question_id
    ORDER BY
      COUNT(question_id) DESC
    SQL

    results.take(n).map { |result| Question.new(result) }
  end
end

class Reply
  include TableSave

  def initialize(options = {})
    @id = options['id']
    @subject_id = options['subject_id']
    @parent_id = options['parent_id']
    @body = options['body']
    @author_id = options['author_id']
    save
  end

  attr_accessor :id, :subject_id, :parent_id, :body, :author_id

  def self.find_by_id(id)
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_user_id(user_id)
    results = QuestionDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      author_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      subject_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def author
    User.find_by_id(author_id)
  end

  def question
    Question.find_by_id(subject_id)
  end

  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end
end

class QuestionLike
  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    results = QuestionDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL

    results.map { |result| QuestionLike.new(result) }
  end

  def self.likers_for_question_id(question_id)
    results = QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_id = ?
    SQL
    p results
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(user_id)
    FROM
      question_likes
    WHERE
      question_id = ?
    GROUP BY
      question_id
    SQL
    results[0].values.first
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      questions
    JOIN
      question_likes ON question_id = questions.id
    WHERE
      user_id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionDatabase.instance.execute(<<-SQL)
    SELECT
      *
    FROM
      question_likes
    JOIN
      questions ON questions.id = question_id
    GROUP BY
      question_id
    ORDER BY
      COUNT(question_id) DESC
    SQL

    results.take(n).map { |result| Question.new(result) }
  end
end
