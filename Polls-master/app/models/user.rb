class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(:authored_polls, class_name: 'Poll',
            foreign_key: :author_id, primary_key: :id)
  has_many(:responses, class_name: 'Response',
           foreign_key: :user_id, primary_key: :id)

  def completed_polls
    # Poll.find_by_sql(['SELECT polls.*
    # FROM polls
    # INNER JOIN questions
    # ON questions.poll_id = polls.id
    # INNER JOIN answer_choices
    # ON answer_choices.question_id = questions.id
    # LEFT OUTER JOIN
    # (SELECT * FROM responses WHERE responses.user_id = ?) AS r
    # ON r.answer_choice_id = answer_choices.id
    # GROUP BY polls.id
    # HAVING COUNT(DISTINCT questions.id) = COUNT(r.id)',self.id])

    lj = <<-SQL
      LEFT OUTER JOIN (
        SELECT *
        FROM responses
        WHERE responses.user_id = #{self.id}
      ) AS r
      ON answer_choices.id = r.answer_choice_id
    SQL

    Poll.joins(questions: :answer_choices)
    .joins(lj)
    .group("polls.id")
    .having('COUNT(DISTINCT questions.id) = COUNT(r.id)')
  end
end
