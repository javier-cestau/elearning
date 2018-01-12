class HasAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :do_test
end
