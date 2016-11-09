class CustomCommand < ApplicationRecord
  belongs_to :user
  default_scope { order(:id) }
  validates_presence_of :output, :trigger
end
