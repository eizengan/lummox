# frozen_string_literal: true

RSpec.describe Lummox::SDL::Error do
  describe ".set_error" do
    subject(:set_error) { described_class.set_error("oh no! an error happened") }

    it "sets the error stored by SDL and returns an error code" do
      expect(set_error).to be(-1)

      error_message = described_class.send(:get_error)[0]
      expect(error_message).to eq "oh no! an error happened"
    end
  end

  describe ".clear_error" do
    subject(:set_error) { described_class.clear_error }

    before { described_class.set_error("oh no! an error happened") }

    it "clears the error stored by SDL" do
      set_error

      error_message = described_class.send(:get_error)[0]
      expect(error_message).to be_empty
    end
  end

  describe ".raise_current_error" do
    subject(:raise_current_error) { described_class.raise_current_error }

    before { described_class.set_error("oh no! an error happened") }

    it "raises the error stored by SDL" do
      expect { raise_current_error }.to raise_error described_class, "oh no! an error happened"
    end
  end

  describe ".raise_if" do
    subject(:raise_if) { described_class.raise_if { condition } }

    let(:condition) { nil }

    before { described_class.set_error("oh no! an error happened") }

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

    before { described_class.set_error("oh no! an error happened") }

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
