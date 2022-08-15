# frozen_string_literal: true

RSpec.describe Lummox::SDL::Error do
  before { Lummox::SDL::Core.set_error("oh no! an error happened") }

  describe ".raise_current_error" do
    subject(:raise_current_error) { described_class.raise_current_error }

    it "raises the error stored by SDL" do
      expect { raise_current_error }.to raise_error described_class, "oh no! an error happened"
    end
  end

  describe ".raise_if" do
    subject(:raise_if) { described_class.raise_if(condition) { result } }

    let(:condition) { nil }
    let(:result) { nil }

    describe "when the condition evaluates to true" do
      let(:condition) { :nil? }
      let(:result) { nil }

      it "raises the error stored by SDL" do
        expect { raise_if }.to raise_error described_class, "oh no! an error happened"
      end
    end

    describe "when the condition evaluates to false" do
      let(:condition) { :nil? }
      let(:result) { 100 }

      it "does not raise" do
        expect { raise_if }.not_to raise_error
      end
    end
  end

  describe ".raise_unless" do
    subject(:raise_unless) { described_class.raise_unless(condition) { result } }

    let(:condition) { nil }
    let(:result) { nil }

    describe "when the condition evaluates to true" do
      let(:condition) { :nil? }
      let(:result) { nil }

      it "does not raise" do
        expect { raise_unless }.not_to raise_error
      end
    end

    describe "when the condition evaluates to false" do
      let(:condition) { :nil? }
      let(:result) { 100 }

      it "raises the error stored by SDL" do
        expect { raise_unless }.to raise_error described_class, "oh no! an error happened"
      end
    end
  end
end
