require 'spec_helper'
require 'log_parser'

RSpec.describe "WebLogStat::LogParser" do
  
  let(:log_file) {"spec/examples/example.log"}

  describe "::read_log" do

    it "returns log entries in array" do
      expect(WebLogStat::LogParser.read_log(log_file).size).to be == 3 
    end
    
  end


end