class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question
  validate :respondent_is_not_author

  belongs_to(:answer_choice, class_name: 'AnswerChoice',
            foreign_key: :answer_choice_id, primary_key: :id)
  belongs_to(:respondent, class_name: 'User',
            foreign_key: :user_id, primary_key: :id)
  has_one :question, :through => :answer_choice, :source => :question

  def sibling_responses
    Response.select('DISTINCT r2.*').joins(answer_choice: :question)
    .joins('INNER JOIN answer_choices AS a2 ON a2.question_id = questions.id')
    .joins('INNER JOIN responses AS r2 ON r2.answer_choice_id = a2.id')
    .where('answer_choices.id = ? AND (? IS NULL OR r2.id != ?)', self.answer_choice_id, self.id, self.id)


    # Response.find_by_sql(['SELECT DISTINCT r2.*
    #   FROM responses AS r1
    #   INNER JOIN answer_choices AS a1
    #   ON r1.answer_choice_id = a1.id
    #   INNER JOIN questions AS q1
    #   ON a1.question_id = q1.id
    #   INNER JOIN answer_choices AS a2
    #   ON a2.question_id = q1.id
    #   INNER JOIN responses AS r2
    #   ON r2.answer_choice_id = a2.id
    #   WHERE a1.id = ? AND (? IS NULL OR r2.id != ?)', self.answer_choice_id, self.id, self.id])
    #

    # rs = question.responses
    # unless self.id.nil?
    #   rs.where('responses.id != ?', self.id)
    # else
    #   rs
    # end
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: self.user_id)
      errors[:user] << "cannot answer same question more than once."
    end
  end

  def respondent_is_not_author
    po = Poll.joins(questions: :responses)
      .where('responses.id = ?', self.id)
    if po.first.author_id == self.user_id
      errors[:user] << "can't answer own question"
    end
  end
end
