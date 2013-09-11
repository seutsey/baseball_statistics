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
  
  def top_five_improved_fantasy_players_year_to_year(year_one, year_two)
    year_one_scores = get_fantasy_scores_for_year year_one
    year_two_scores = get_fantasy_scores_for_year year_two
    
    player_score_difference = Array.new
    
    year_one_scores.each do |yo|
      year_two_scores.each do |yt|
        if yo[:playerID] == yt[:playerID]
          score_difference = Calculations.calculate_fantasy_score_difference(yo[:fantasy_score].to_f, yt[:fantasy_score].to_f)
          player_score_difference.push({playerID: yo[:playerID], score_difference: score_difference})
          break
        end
      end
    end
    player_out = Array.new
    players = Players.new
    
    player_score_difference.sort_by { |x| x[:score_difference] }.reverse.take(5).each do |p|
      player_out.push("     #{ players.player_name_by_id(p[:playerID]) } improved by #{ p[:score_difference].to_i } points")
    end
    player_out
  end
  
  def get_fantasy_scores_for_year(year)
    scores_for_year = Array.new
    
    @batting_statistics.each do |b|
      if b[:yearID].to_i == year.to_i and b[:AB].to_i >= 500
        scores_for_year.push(Calculations.calculate_fantasy_score(b[:playerID], b[:yearID], b[:HR], b[:RBI], b[:SB], b[:CS]))
      end
    end
    
    scores_for_year
  end
end



