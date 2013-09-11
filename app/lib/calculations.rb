require "active_record"
require_relative "fantasy_scoring"

class Calculations
  def self.calculate_batting_average(hits, at_bats)
    hits.to_f / at_bats.to_f
  end
  
  def self.calculate_slugging_percentage(hits, doubles, triples, home_runs, at_bats)
    "#{ (((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats * 100).round(3) } %"
  end
  
  def self.calculate_fantasy_score(playerID, year, home_runs, rbis, stolen_bases, caught_stealing)
    score = (home_runs.to_f * FantasyScoring.home_run) + (rbis.to_f * FantasyScoring.rbi) + (stolen_bases.to_f * FantasyScoring.stolen_base) - (caught_stealing.to_f * FantasyScoring.caught_stealing.abs)
    {playerID: playerID, yearID: year, fantasy_score: score}
  end
  
  def self.calculate_fantasy_score_difference(score_one, score_two)
    score_two - score_one
  end
end