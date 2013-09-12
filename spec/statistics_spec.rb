require_relative "../app/lib/statistics"
require "rspec"

class StatisticsSpec
  describe Statistics do
    before :each do
      @statistics = Statistics.new
    end
    
    describe ".batting_file" do
      it "should exist" do
        @statistics.batting_statistics.first.should_not be_nil
      end     
    end
    
    describe ".most_improved_player_by_batting_average" do
      before :each do
        @most_improved = @statistics.most_improved_player_by_batting_average
      end
      
      it "should return a hash" do
        @most_improved.should be_a(Hash)
      end
      
      it "should return playerId 'mauerjo01'" do
        @most_improved[:playerID].should == "mauerjo01"
      end
      
      it "should return birthYear '1983'" do
        @most_improved[:birthYear].should == "1983"
      end
      
      it "should return nameFirst 'Joe'" do
        @most_improved[:nameFirst].should == "Joe"
      end
      
      it "should return nameLast 'Mauer'" do
        @most_improved[:nameLast].should == "Mauer"
      end
    end
    
    describe ".team_slugging_percentage" do
      it "should return 18.128 % for OAK in 2007" do
        @statistics.team_slugging_percentage.should == "18.128 %"
      end
    end
    
    describe ".top_five_improved_fantasy_players_year_to_year" do
      before :each do
        @top_five = @statistics.top_five_improved_fantasy_players_year_to_year(2011, 2012)
      end
      
      it "should return 5 records" do
        @top_five.count.should == 5
      end
      
      it "should return Alexis Rios as the most improved." do
        @top_five.first.strip.should == "Alexis Rios improved by 107 points"
      end
    end
    
    describe ".triple_crown_winner_for_year" do
      it "should return Miguel Cabrera for 2012" do
        @statistics.triple_crown_winner_for_year(2012).should == "Miguel Cabrera"
      end
      
      it "should return (No Winner) if there was no winner" do
        @statistics.triple_crown_winner_for_year(2011).should == "(No Winner)"
      end
    end
  end
end