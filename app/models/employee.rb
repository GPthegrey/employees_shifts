class Employee < ApplicationRecord
  has_many :assignments
  has_many :shifts, through: :assignments
end
