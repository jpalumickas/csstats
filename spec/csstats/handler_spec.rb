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

    it 'should return correct player rank' do
      expect(@player.rank).to eq 2
    end

    it 'should return correct player teamkill' do
      expect(@player.teamkill).to eq 7
    end

    it 'should return correct player damage' do
      expect(@player.damage).to eq 101_543
    end

    it 'should return correct player deaths' do
      expect(@player.deaths).to eq 511
    end

    it 'should return correct player kills' do
      expect(@player.kills).to eq 759
    end

    it 'should return correct player shots' do
      expect(@player.shots).to eq 9421
    end

    it 'should return correct player hits' do
      expect(@player.hits).to eq 2885
    end

    it 'should return correct player headshots' do
      expect(@player.headshots).to eq 225
    end

    it 'should return correct player defusions' do
      expect(@player.defusions).to eq 15
    end

    it 'should return correct player defused' do
      expect(@player.defused).to eq 9
    end

    it 'should return correct player plants' do
      expect(@player.plants).to eq 33
    end

    it 'should return correct player explosions' do
      expect(@player.explosions).to eq 7
    end

    it 'should return correct player head' do
      expect(@player.head).to eq 275
    end

    it 'should return correct player chest' do
      expect(@player.chest).to eq 407
    end

    it 'should return correct player stomach' do
      expect(@player.stomach).to eq 376
    end

    it 'should return correct player leftarm' do
      expect(@player.leftarm).to eq 1126
    end

    it 'should return correct player rightarm' do
      expect(@player.rightarm).to eq 283
    end

    it 'should return correct player leftleg' do
      expect(@player.leftleg).to eq 202
    end

    it 'should return correct player rightleg' do
      expect(@player.rightleg).to eq 214
    end

    it 'should return correct player accuracy' do
      expect(@player.acc).to eq 30.62
    end

    it 'should return correct player efficiency' do
      expect(@player.eff).to eq 59.76
    end

    it 'should not return empty data' do
      expect(@player['-']).to eq nil
    end
  end
end
