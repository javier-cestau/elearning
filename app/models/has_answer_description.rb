class HasAnswerDescription < ApplicationRecord
  belongs_to :question
  belongs_to :do_test
end
