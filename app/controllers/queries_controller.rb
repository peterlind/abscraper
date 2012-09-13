class QueriesController < ApplicationController
  respond_to :json, :xml, :html

  def show
    input = params[:id]
    unless input.present?
      redirect_to root_url
      return
    end
    @query = Query.fetch_result(input)
    respond_with @query
  end

  def index
    @query = Query.new
    respond_with @query
  end

  def create
    q = Query.new(params[:query])
    redirect_to query_path(q)
  end
end
