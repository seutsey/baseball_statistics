require "active_record"

class Calculations
  def self.calculate_batting_average(hits, at_bats)
    hits.to_f / at_bats.to_f
  end
  
  def self.calculate_slugging_percentage(hits, doubles, triples, home_runs, at_bats)
    "#{ (((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats * 100).round(3) } %"
  end
end