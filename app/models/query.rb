class Query < ActiveRecord::Base

  def as_json(*options)
    super(except: exempted_fields)
  end

  def to_xml(*options)
    super(except: exempted_fields)
  end

  private
  def exempted_fields
    [:id, :created_at, :updated_at, :user_agent, :remote_ip]
  end
end
