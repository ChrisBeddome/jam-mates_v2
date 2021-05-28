# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfileInstrument, type: :model do
  let(:instrument) { create(:instrument) }
  let(:profile) { create(:profile) }
  before(:each) do
    profile.instruments << instrument
  end

  describe "uniqueness constraints" do
    context "when trying to add instrument to profile twice" do
      it "should raise exception" do
        expect { profile.instruments << instrument }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
    context "when trying to add profile to instrument twice" do
      it "should raise exception" do
        expect { instrument.profiles << profile }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "destroying relata" do
    context "when instrument is destroyed" do
      it "should destroy associated ProfileInstrument" do
        expect { instrument.destroy }.to change { described_class.count }.by(-1)
      end
    end
    context "when profile is destroyed" do
      it "should destroy associated ProfileInstrument" do
        expect { profile.destroy }.to change { described_class.count }.by(-1)
      end
    end
  end
end
