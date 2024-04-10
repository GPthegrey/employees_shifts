class Request < ApplicationRecord
  belongs_to :employee
  belongs_to :shift
end
