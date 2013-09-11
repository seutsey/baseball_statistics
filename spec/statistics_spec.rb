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
  end
end