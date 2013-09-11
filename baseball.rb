require_relative "app/lib/statistics"

stats = Statistics.new
player = stats.most_improved_player_by_batting_average
$stdout.puts "Most Improved Player (Batting Average): #{player[:nameFirst]} #{player[:nameLast]}"
$stdout.puts "Team slugging percentage for Oakland Athletics in 2007: #{stats.team_slugging_percentage "OAK", "2007" }"
