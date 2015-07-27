class Quote < Textutil
  belongs_to :user
  default_scope { order(:id) }
end
