class QueriesController < ApplicationController
  respond_to :json, :xml

  def show
    input = params[:id]
    if input
      query = Query.fetch_result(input)
    else
      query = Query.new
    end
    respond_with query
  end
end
