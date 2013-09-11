require_relative "parser"
require "active_record"

class Players
  attr_accessor :player_records

  def initialize
    @player_records = player_file
  end
  
  def player_file
    Parser.parse_csv "master.csv"
  end
  
  def player_by_id(id)
    player = Hash.new
    @player_records.each do |p|
      player = p if p[:playerID] == id
    end
    player
  end
end