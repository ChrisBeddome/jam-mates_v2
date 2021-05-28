# frozen_string_literal: true

require "rails_helper"

RSpec.describe Instrument, type: :model do
  let(:instrument) { build :instrument, attrs }
  let(:valid_attrs) {
    {
      name: "Super dope music maker machine"
    }
  }

  context "with valid attributes" do
    let(:attrs) { valid_attrs }
    it "is valid" do
      expect(instrument).to be_valid
    end
  end

  context "without name" do
    let(:attrs) { valid_attrs.merge({name: nil}) }
    it "is invalid" do
      expect(instrument).to be_invalid
    end
  end

  context "name taken" do
    let!(:instrument2) { create(:instrument, name: "Super dope music maker machine") }
    let(:attrs) { valid_attrs }
    it "is invalid" do
      expect(instrument).to be_invalid
    end
  end
end
