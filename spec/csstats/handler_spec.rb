require 'spec_helper'

describe CSstats::Handler do

  before do
    @handler = CSstats::Handler.new(path: csstats_file, maxplayers: 15)
  end

  it "should return corrent players count" do
    expect(@handler.players_count).to eq 15
  end

  it "should return correct player data" do
    expect(@handler.player(2).nick).to eq "CHMARSON"
  end

end