require "active_record"
require "CSV"

class Parser < ActiveRecord::Base
  def self.parse_csv(file_to_parse)
    csv = CSV.parse(File.read("#{Dir.pwd}/files/#{file_to_parse}"), headers:true)
    arr = []
    csv.each do |row|
      arr.push(row.to_hash.symbolize_keys)
    end
    arr
  end
end