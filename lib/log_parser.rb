module WebLogStat


  class LogParser

    def self.read_log(file)
      log_entry = Struct.new(:uri, :ip_addr)
      
      File.read(file).split(/\n+/).map do |line|
        uri, ip_addr = line.split(/\s+/)
        log_entry.new(uri, ip_addr)
      end

    end

  end

end