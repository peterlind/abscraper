require 'spec_helper'

describe Query do
  context 'formatting' do
    before(:each) do
      @query = Query.new.tap do |q|
        q.remote_ip = '1'
        q.user_agent = 'a'
        q.input = 'b'
        q.result = '2'
      end
    end
    describe '#as_json' do
      it 'only returns input and result' do
        json = JSON.parse @query.to_json
        json['result'].should == '2'
        json['input'].should == 'b'
        json.keys.should =~ ['input', 'result']
      end
    end
    describe '#as_xml' do
      it 'only returns input and result' do
        xml = Nokogiri::XML @query.to_xml
        xml.xpath('//query/user-agent').text.should be_blank
        xml.xpath('//query/remote-ip').text.should be_blank
        xml.xpath('//query/input').text.should == 'b'
        xml.xpath('//query/result').text.should == '2'
      end
    end
  end
end
