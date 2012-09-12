require 'spec_helper'

describe Query do
  describe '#as_json' do
    it 'only returns input and result' do
      q = Query.new.tap do |q|
        q.remote_ip = '1'
        q.user_agent = 'a'
        q.input = 'b'
        q.result = '2'
      end
      json = q.as_json
      json['input'].should == 'b'
      json['result'].should == '2'
      json.keys.should =~ ['input', 'result']
    end
  end
end
