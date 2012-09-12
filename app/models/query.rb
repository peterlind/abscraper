class Query < ActiveRecord::Base
  attr_accessible :input, :remote_ip, :result, :user_agent
end
