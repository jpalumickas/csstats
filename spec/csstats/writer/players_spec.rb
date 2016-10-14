require 'spec_helper'

describe CSstats::Writer::Players do
  let(:old_players) { CSstats::Handler.new(path: csstats_file).players }
  let(:file_path) { tmp_file('test.dat') }
  let(:new_players) { CSstats::Handler.new(path: file_path).players }

  it 'has correct players count in main file' do
    expect(old_players.length).to eq(208)
  end

  context 'new file' do
    before do
      CSstats::Writer::Players.new(old_players).write(file_path)
    end

    it 'has correct players count' do
      CSstats::Writer::Players.new(old_players).write(file_path)
      expect(new_players.length).to eq(208)
    end

    it 'has same players data' do
      expect(old_players).to eq(new_players)
    end
  end
end
