# frozen_string_literal: true

RSpec.describe Lummox::SDLError do
  describe ".raise_current_error" do
    subject(:raise_current_error) { described_class.raise_current_error }

    before { Lummox::SDL::Error.set_error("oh no! an error happened") }

    it "raises the error stored by SDL" do
      expect { raise_current_error }.to raise_error described_class, "oh no! an error happened"
    end
  end

  describe ".raise_if" do
    subject(:raise_if) { described_class.raise_if { condition } }

    let(:condition) { nil }

    before { Lummox::SDL::Error.set_error("oh no! an error happened") }

    describe "when the condition evaluates to true" do
      let(:condition) { true }

      it "raises the error stored by SDL" do
        expect { raise_if }.to raise_error described_class, "oh no! an error happened"
      end
    end

    describe "when the condition evaluates to false" do
      let(:condition) { false }

      it "does not raise" do
        expect { raise_if }.not_to raise_error
      end
    end
  end

  describe ".raise_unless" do
    subject(:raise_unless) { described_class.raise_unless { condition } }

    let(:condition) { nil }

    before { Lummox::SDL::Error.set_error("oh no! an error happened") }

    describe "when the condition evaluates to true" do
      let(:condition) { true }

      it "does not raise" do
        expect { raise_unless }.not_to raise_error
      end
    end

    describe "when the condition evaluates to false" do
      let(:condition) { false }

      it "raises the error stored by SDL" do
        expect { raise_unless }.to raise_error described_class, "oh no! an error happened"
      end
    end
  end
end
