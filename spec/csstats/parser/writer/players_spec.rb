require 'spec_helper'

describe CSstats::Parser::Writer::Players do
  let(:old_players) { CSstats.new(path: csstats_file).players }
  let(:file_path) { tmp_file('test.dat') }
  let(:new_players) { CSstats.new(path: file_path).players }

  it 'has correct players count in main file' do
    expect(old_players.length).to eq(208)
  end

  context 'new file' do
    before do
      described_class.new(file_path).write(old_players)
    end

    it 'has correct players count' do
      described_class.new(file_path).write(old_players)
      expect(new_players.length).to eq(208)
    end

    it 'has same players data' do
      expect(old_players.map(&:as_json)).to eq(new_players.map(&:as_json))
    end
  end
end
