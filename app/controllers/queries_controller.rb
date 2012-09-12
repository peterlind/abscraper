class QueriesController < ApplicationController
  respond_to :json, :xml

  def show
    input = params[:id]
    query = Query.fetch_result(input)
    respond_with query
  end
end
