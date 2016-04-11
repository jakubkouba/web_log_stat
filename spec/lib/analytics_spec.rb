require 'spec_helper'
require 'analytics'


RSpec.describe "WebLogStat::Analytics" do

  let(:analitycs) { WebLogStat::Analytics.new(log_entries) }
  let(:log_entries) do
    log_entry = Struct.new(:uri, :ip_addr)
    [
      log_entry.new('/home', '192.168.0.10'),
      log_entry.new('/home', '192.168.0.11'),
      log_entry.new('/home', '192.168.0.11'),
      log_entry.new('/index', '192.168.0.10'),
      log_entry.new('/index', '192.168.0.11'),
      log_entry.new('/index', '192.168.0.11'),
      log_entry.new('/index', '192.168.0.12'),
      log_entry.new('/index', '192.168.0.12')
    ]
  end

  describe "#hits_by_page" do

    it "returns array of hashes containing uri and number of hits" do
      result = analitycs.send(:collect_hits_by_page)
      expect(result.first.ip_addresses.size).to be == 3
    end

  end

end
