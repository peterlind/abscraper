require 'spec_helper'

describe QueriesController do
  context '#new' do
    context 'cached result' do
      it 'returns json if requested' do
        Query.stub(:where).and_return([Query.new( result:'123456-7890')])
        get :show, id: 'test', format: :json
        response.should be_successful
        output = JSON.parse(response.body)
        output['result'].should == '123456-7890'
     end
    end
  end
end
