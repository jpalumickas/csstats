require 'spec_helper'

describe CSstats::Parser::Reader::Player do
  let(:file_stream) { File.new(csstats_file) }
  let(:streamer) { CSstats::Parser::Reader::FileStreamer.new(file_stream) }
  subject { described_class.new(streamer) }
  let(:player_data) { subject.parse }

  before do
    # We need to read first bytes, because it's file version.
    streamer.read_short_data
  end

  it 'has correct head' do
    expect(player_data.head).to eq(402)
  end
end
