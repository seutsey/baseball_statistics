require_relative "app/lib/statistics"

stats = Statistics.new
player = stats.most_improved_player_by_batting_average
$stdout.puts "Most Improved Player (Batting Average): #{player[:nameFirst]} #{player[:nameLast]}"
$stdout.puts "Team slugging percentage for Oakland Athletics in 2007: #{stats.team_slugging_percentage "OAK", "2007" }"
$stdout.puts "Top 5 most improved fantasy players from 2011 - 2012:"
$stdout.puts stats.top_five_improved_fantasy_players_year_to_year(2011, 2012)
$stdout.puts "Triple Crown Winner for 2011: #{ stats.triple_crown_winner_for_year 2011 }" 
$stdout.puts "Triple Crown Winner for 2012: #{ stats.triple_crown_winner_for_year 2012 }"