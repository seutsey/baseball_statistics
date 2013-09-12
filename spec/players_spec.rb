require_relative "../app/lib/players"
require "rspec"

class PlayersSpec
  describe Players do
    before :each do
      @players = Players.new
    end   
    
    describe ".player_file" do
      it "should exist" do
        @players.player_file.first.should_not be_nil
      end
    end
    
    describe ".player_by_id" do
      it "should return Hank Aaron's player record for playerID: aaronha01" do
        player = @players.player_by_id "aaronha01"
        player[:nameFirst].should == "Hank"
        player[:nameLast].should == "Aaron"
      end
    end
    
    describe ".player_name_by_id" do
      it "should return the name 'Hank Aaron' for playerId: aaronha01" do
        @players.player_name_by_id("aaronha01").should == "Hank Aaron"
      end
    end
  end
end