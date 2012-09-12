class Query < ActiveRecord::Base

  def self.fetch_result(input)
    q = ::Query.where(input: input).first
    unless q
      result = AllaBolagScraper.get_remote_result(input)
      q = ::Query.new
      q.input = input
      q.result = result
      q.save if result
    end
    q
  end

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
