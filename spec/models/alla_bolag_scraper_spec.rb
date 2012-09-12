require 'spec_helper'

describe AllaBolagScraper do
  context 'results found' do
    it 'parses and returns results' do
      VCR.use_cassette('ab-apoex') do
        AllaBolagScraper.get_remote_result('apoex').to_s.should =~ /556633-4149/
      end
    end
  end
  context '#parse_org_nr' do
    it 'parse and formats input' do
      AllaBolagScraper.parse_org_nr('http://www.allabolag.se/5566334149/ApoEx_AB').should == '556633-4149'
    end
  end
end
