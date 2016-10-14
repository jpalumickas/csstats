require 'spec_helper'

describe CSstats::Parser::Player do
  let(:file_stream) { File.new(csstats_file) }
  let(:handler) { CSstats::Parser::FileReader::Handler.new(file_stream) }
  subject { described_class.new }
  let(:player_data) { subject.parse(handler) }

  before do
    # We need to read first bytes, because it's file version.
    handler.read_short_data
  end

  it 'has correct acc' do
    expect(player_data.acc).to eq(24.3)
  end
end
