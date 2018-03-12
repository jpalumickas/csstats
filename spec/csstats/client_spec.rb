require 'spec_helper'

describe CSstats::Client do
  let(:client) { CSstats::Client.new(path: csstats_file, max_players: 5) }

  it 'has correct file path' do
    expect(client.file_path).to eq(csstats_file)
  end

  it 'has correct max players value' do
    expect(client.max_players).to eq(5)
  end
end
