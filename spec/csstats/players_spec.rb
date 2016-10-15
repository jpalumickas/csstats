require 'spec_helper'

describe CSstats::Players do
  let(:client) { CSstats::Client.new(path: csstats_file, maxplayers: 30) }
  let(:players) { client.players }

  it 'has corrent players count' do
    expect(players.count).to eq(30)
  end

  it 'has array of Player class' do
    expect(players.first).to be_a(CSstats::Player)
  end

  it 'has correct player data' do
    expect(players.find(2).nick).to eq('CHMARSON')
  end

  it 'has correct count with where' do
    expect(players.where(head: 102).count).to eq(2)
  end

  it 'has correct count with find_by' do
    expect(players.find_by(head: 102).nick).to eq('LBM')
  end
end
