class User < ActiveRecord::Base
  before_save {
    #do stuff
  }
end
