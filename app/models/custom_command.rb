class CustomCommand < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :name, :output, :trigger

end
