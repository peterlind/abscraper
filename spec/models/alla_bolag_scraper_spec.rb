require 'spec_helper'

describe AllaBolagScraper do
  context 'results found' do
    it 'parses and returns results' do
      VCR.use_cassette('ab-apoex') do
        result = AllaBolagScraper.get_remote_result('apoex ab')
        result.keys.should == ['ApoEx AB']
        result['ApoEx AB'].should == '556633-4149'
      end
    end
  end
  context 'no results in scraped page' do
    #response code is still 200
    it 'returns empty hash' do
      VCR.use_cassette('ab-asdafasdaf') do
        result = AllaBolagScraper.get_remote_result('asdafasdaf')
        result.should be_empty
      end
    end
  end
  context 'server error' do
    #restclient returns nil on 500
    it 'returns nil' do
      AllaBolagScraper.should_receive(:http_get).and_return(nil)
      AllaBolagScraper.get_remote_result('BOOM').should be_nil
    end
  end
  context '#parse_org_nr' do
    it 'parse and formats input' do
      AllaBolagScraper.parse_org_nr('http://www.allabolag.se/5566334149/ApoEx_AB').should == '556633-4149'
    end
  end
  context 'single result' do
    it 'returns single result when exact match found' do
      result = {'alfa' => '123', 'alfabeta' => '234'}
      single = AllaBolagScraper.find_single_result_if_possible(result, 'alfa')
      single.keys.should == ['alfa']
      single['alfa'].should == '123'
    end
    it 'returns single result when normalized match found' do
      result = {'al fa' => '123', 'alfa beta' => '234'}
      single = AllaBolagScraper.find_single_result_if_possible(result, 'ALFA')
      single.keys.should == ['al fa']
      single['al fa'].should == '123'
    end
  end
end
