require 'log_parser.rb'
require 'byebug'

module WebLogStat

  class Analytics

    def initialize(log_entries)
      @log_entries = log_entries
    end

    private

    def collect_hits_by_page 
      @hits_by_page = []
      @log_entries.each do |log_entry|
        page = nil  

        @hits_by_page.each do |page_hit|
          if page_hit.page == log_entry.uri
            page = page_hit
            break
          end 
        end

        if page
          page.ip_addresses << log_entry.ip_addr
        else
          @hits_by_page << page_hits(log_entry.uri, [log_entry.ip_addr])
        end

      end 
      @hits_by_page   
    end

    def page_hits(page, ip_addr)
      ph = Struct.new(:page, :ip_addresses)
      ph.new(page, ip_addr)
    end

  end

end
