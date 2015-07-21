class CustomCommand < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :name, :admin, :on, :limit, :output

end
