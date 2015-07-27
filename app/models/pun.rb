class Pun < Textutil
  belongs_to :user
  default_scope { order(:id) }
end
