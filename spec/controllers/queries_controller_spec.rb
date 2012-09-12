require 'spec_helper'

describe QueriesController do
  context '#new' do
    context 'cached result' do
      before(:each) do
        Query.stub(:where).and_return([Query.new.tap{|q| q.result ='123456-7890'}])
      end
      it 'returns json if requested' do
        get :show, id: 'test', format: :json
        response.should be_successful
        output = JSON.parse response.body
        output['result'].should == '123456-7890'
      end
      it 'returns xml if requested' do
        get :show, id: 'test', format: :xml
        response.should be_successful
        output = Nokogiri::XML response.body
        output.xpath('//query/result').text.should == '123456-7890'
      end
    end
  end
end
