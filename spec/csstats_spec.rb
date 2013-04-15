require 'spec_helper'

describe CSstats do

  describe ".new" do
    it "is a CSstats::Handler" do
      expect(CSstats.new).to be_a CSstats::Handler
    end
  end

end