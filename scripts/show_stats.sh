#!/usr/bin/env ruby

$:.unshift('../lib')

require 'log_parser'
require 'analytics'

if ARGV.empty?
  puts "Enter log file"
  exit
end

log_file = ARGV[0]

log_parser = WebLogStat::LogParser
analytics = WebLogStat::Analytics.new(log_parser.read_log(log_file))

print_results = Proc.new do |results, method, label|
  results.each { |result| puts "#{result.page} #{result.send(method)} #{label} \n"}	
end

puts "\n"
puts "---------------"
puts "Most page views \n"
puts "---------------"

print_results.call(analytics.most_hits_pages, :total_hits, 'visits')
puts "\n"

puts "----------------------"
puts "Most single page views \n"
puts "----------------------"

print_results.call(analytics.unique_hits, :unique_hits, 'unique visits')

puts "\n"

