require 'spec_helper'

describe CSstats do
  describe '.new' do
    it 'is a CSstats::Handler' do
      expect(CSstats.new(path: csstats_file)).to be_a CSstats::Handler
    end

    it 'is a CSstats::FileNotFound if file path empty' do
      expect { CSstats.new }.to raise_error(CSstats::FileNotExist)
    end
  end
end
