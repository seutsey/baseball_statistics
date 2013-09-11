require_relative "calculations"
require_relative "parser"
require_relative "players"

class Statistics 

  attr_accessor :batting_statistics

  def initialize
    @batting_statistics = batting_file
  end
 
  def batting_file
    Parser.parse_csv "batting.csv"
  end
  
  def most_improved_player_by_batting_average
    most_improved = ""
    batting_average = 0
    @batting_statistics.each do |stats|
      if stats[:AB].to_i >= 200
        current_batting_average = Calculations.calculate_batting_average stats[:H], stats[:AB]
        most_improved = stats[:playerID] unless current_batting_average < batting_average
        batting_average = current_batting_average unless current_batting_average < batting_average
      end      
    end
    
    player = Players.new
    player.player_by_id most_improved
  end
  
  def team_slugging_percentage(team_id = "OAK", year = "2007")
    #this is more bloated than I'd prefer, but I was having issues with array conversions.
    hits = Array.new
    doubles = Array.new
    triples = Array.new
    home_runs = Array.new
    at_bats = Array.new
    
    @batting_statistics.each do |b|
      if b[:teamID] == team_id and b[:yearID].to_i == year.to_i
        hits.push(b[:H].to_f)
        doubles.push(b[:"2B"].to_f)
        triples.push(b[:"3B"].to_f)
        home_runs.push(b[:HR].to_f)
        at_bats.push(b[:AB].to_f)
      end
    end

    h = hits.reduce(0) { |t, v| v ? t += v : t }
    d = doubles.reduce(0) { |t, v| v ? t += v : t}
    tr = triples.reduce(0) { |t, v| v ? t += v : t}
    h = home_runs.reduce(0) { |t, v| v ? t += v : t}
    a = at_bats.reduce(0) { |t, v| v ? t += v : t}
    Calculations.calculate_slugging_percentage h, d, tr, h, a
  end
end



