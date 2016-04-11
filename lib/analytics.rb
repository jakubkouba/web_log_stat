require 'log_parser.rb'
require 'byebug'

module WebLogStat

  class Analytics

    def initialize(log_entries)
      @log_entries = log_entries
    end

    def most_hits_pages
      collect_hits_by_page.sort_by(&:total_hits).reverse
    end

    def unique_hits
      collect_hits_by_page.sort_by(&:unique_hits).reverse
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
      ph = Struct.new(:page, :ip_addresses) do
        def total_hits
          self.ip_addresses.size  
        end

        def unique_hits
          self.ip_addresses.uniq.size 
        end

      end
      ph.new(page, ip_addr)
    end

  end

end
