# frozen_string_literal: true

RSpec.describe Lummox::SDL do
  it "has a version number" do
    expect(Lummox::SDL::VERSION).not_to be_nil
  end

  describe ".init!" do
    subject(:init!) { described_class.init!(*subsystems) }

    let(:subsystems) { [] }

    describe "when no subsystems are specified" do
      let(:subsystems) { [] }

      it "initializes all subsystems" do
        init!
        expect(described_class.init_subsystems).to match_array(described_class::SUBSYSTEMS)
      end
    end

    describe "when subystems are specified" do
      let(:subsystems) { %i[audio video] }

      it "initializes specified subsystems and their dependencies" do
        init!
        expect(described_class.init_subsystems).to contain_exactly(:audio, :video, :events)
      end
    end

    describe "when initialization fails" do
      before do
        allow(Lummox::SDL::Initialization).to receive(:init).and_return(-1)
        Lummox::SDL::Error.set_error("oh no! an error happened")
      end

      it "raises an error with the expected message" do
        expect { init! }.to raise_error Lummox::SDLError, "oh no! an error happened"
      end
    end
  end

  describe ".init?" do
    subject(:init?) { described_class.init?(:audio, :video) }

    describe "when all specified systems have been initialized" do
      before { described_class.init!(:audio, :video) }

      it { is_expected.to be true }
    end

    describe "when some specified systems are not initialized" do
      before { described_class.init!(:audio) }

      it { is_expected.to be false }
    end
  end

  %i[timer audio video joystick haptic gamecontroller events sensor].each do |subsystem|
    describe ".#{subsystem}_init!" do
      subject(:subsystem_init!) { described_class.send(:"#{subsystem}_init!") }

      before { allow(described_class).to receive(:init!) }

      it "tries to initialize the #{subsystem} subsystem" do
        subsystem_init!
        expect(described_class).to have_received(:init!).once.with(subsystem)
      end
    end

    describe ".#{subsystem}_init?" do
      subject(:subsystem_init?) { described_class.send(:"#{subsystem}_init?") }

      before { allow(described_class).to receive(:init?).and_return(:initialization_status) }

      it "checks whether the #{subsystem} subsystem is initialized" do
        expect(subsystem_init?).to be :initialization_status
      end
    end
  end

  describe ".init_subsystems" do
    subject(:init_subsystems) { described_class.init_subsystems }

    before { described_class.init!(:audio, :video) }

    it "returns a list of all initialized subsystems" do
      expect(init_subsystems).to contain_exactly(:audio, :video, :events)
    end
  end

  describe ".quit!" do
    subject(:quit!) { described_class.quit! }

    before { described_class.init! }

    it "shuts down all initialized subsystems" do
      quit!
      expect(described_class.init_subsystems).to be_empty
    end
  end
end
