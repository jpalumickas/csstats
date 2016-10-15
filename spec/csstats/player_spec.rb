require 'spec_helper'

describe CSstats::Player do
  let(:client) { CSstats::Client.new(path: csstats_file, maxplayers: 10) }
  let(:players) { client.players }
  let(:player) { players.find_by(nick: 'CHMARSON') }

  it 'has correct nick' do
    expect(player.nick).to eq 'CHMARSON'
  end

  it 'has correct rank' do
    expect(player.rank).to eq 2
  end

  it 'has correct teamkill' do
    expect(player.teamkill).to eq 7
  end

  it 'has correct damage' do
    expect(player.damage).to eq 101_543
  end

  it 'has correct deaths' do
    expect(player.deaths).to eq 511
  end

  it 'has correct kills' do
    expect(player.kills).to eq 759
  end

  it 'has correct shots' do
    expect(player.shots).to eq 9421
  end

  it 'has correct hits' do
    expect(player.hits).to eq 2885
  end

  it 'has correct headshots' do
    expect(player.headshots).to eq 225
  end

  it 'has correct defusions' do
    expect(player.defusions).to eq 15
  end

  it 'has correct defused' do
    expect(player.defused).to eq 9
  end

  it 'has correct plants' do
    expect(player.plants).to eq 33
  end

  it 'has correct explosions' do
    expect(player.explosions).to eq 7
  end

  it 'has correct head' do
    expect(player.head).to eq 275
  end

  it 'has correct chest' do
    expect(player.chest).to eq 407
  end

  it 'has correct stomach' do
    expect(player.stomach).to eq 376
  end

  it 'has correct leftarm' do
    expect(player.leftarm).to eq 1126
  end

  it 'has correct rightarm' do
    expect(player.rightarm).to eq 283
  end

  it 'has correct leftleg' do
    expect(player.leftleg).to eq 202
  end

  it 'has correct rightleg' do
    expect(player.rightleg).to eq 214
  end

  it 'has correct accuracy' do
    expect(player.accuracy).to eq 30.62
  end

  it 'has correct efficiency' do
    expect(player.efficiency).to eq 59.76
  end
end
