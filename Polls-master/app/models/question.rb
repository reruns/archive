class Question < ActiveRecord::Base
  validates :text, presence: true

  belongs_to(:poll, class_name: 'Poll',
            foreign_key: :poll_id, primary_key: :id)

  has_many(:answer_choices, class_name: 'AnswerChoice',
          foreign_key: :question_id, primary_key: :id)

  has_many :responses, :through => :answer_choices, :source => :responses

  def results
    response_counts = self
      .answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_counts")
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .group('answer_choices.id')

    response_hash = {}

    response_counts.each do |response|
      response_hash[response.text] = response.response_counts
    end

    response_hash
  end

end


# SELECT answer_choices.*, COUNT(responses.id) AS response_counts
# FROM answer_choices
# LEFT OUTER JOIN responses
# ON responses.answer_choice_id = answer_choices.id
# INNER JOIN questions
# ON questions.id = answer_choices.question_id
# WHERE questions.id = self.id
# GROUP BY answer_choices.id
