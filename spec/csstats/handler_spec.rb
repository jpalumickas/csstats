require 'spec_helper'

describe CSstats::Handler do

  before do
    @handler = CSstats::Handler.new(path: csstats_file, maxplayers: 15)
  end

  it 'should return corrent players count' do
    expect(@handler.players_count).to eq 15
  end

  it 'should return correct player data' do
    expect(@handler.player(2).nick).to eq 'CHMARSON'
  end

  describe 'player with specified name' do

    before do
      @player = @handler.search_by_name('CHMARSON')
    end

    it 'should return searched player' do
      expect(@player.nick).to eq 'CHMARSON'
    end

    it 'should return correct player accuracy' do
      expect(@player.acc).to eq 30.62
    end

    it 'should return correct player efficiency' do
      expect(@player.eff).to eq 59.76
    end

  end
end
