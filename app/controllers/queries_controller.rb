class QueriesController < ApplicationController
  respond_to :json

  def show
    input = params[:id]
    query = Query.where(input: input).first
    respond_with query
  end
end
