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
  context 'caching' do
    it 'returns result if cached' do
       Query.create!.tap do |q|
        q.input = 'ab'
        q.result = '223344-5566'
        q.save
      end
       q = Query.fetch_result 'ab'
       q.result.should == '223344-5566'
    end
    it 'fetches and saves result if not cached' do
      AllaBolagScraper.should_receive(:get_remote_result).with('nope').and_return('112233-4455')
      q = Query.fetch_result 'nope'
      q.result.should == '112233-4455'
      Query.where(input: 'nope').first.should be_present
    end
  end
end
