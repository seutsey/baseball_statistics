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
  end
end