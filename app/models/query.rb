class Query < ActiveRecord::Base
  #attr_accessible :input, :remote_ip, :result, :user_agent

  def as_json(*options)
    super(except: [:id, :created_at, :updated_at, :user_agent, :remote_ip])
  end
end
