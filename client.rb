require 'rubygems'
require 'open-uri'
require 'json'
require 'optparse'

opt = OptionParser.new do |o|
  o.on('-h HOST') { |host| @host = host }
end

opt.parse!(ARGV)
puts opt unless ARGV

@term = ARGV.join(' ')
@host ||= 'http://localhost:3000/'

puts 'Fetching...'

s = open("#{@host}/queries/#{URI.encode(@term)}").string

json = JSON.parse(s)
result = json['result']

unless result.empty?
  puts "Results for '#{@term}'"
  result.each do |k, v|
    puts "#{k} -> #{v}"
  end
else
  puts "No results for '#{@term}'"
end


