require './lib/Oyster'
describe Oyster do
  before(:each) { subject.balance = 1.00 }
  let(:station) { double :station }
  context 'Feature 1 - Balance' do
    describe '#balance' do
      it { expect(subject).to respond_to(:balance) }
      it { expect(defined? Travel::MAXIMUM_BALANCE).to eq('constant') }
    end
  end
  context 'Feature 2' do
    describe '#top-up' do
      it { expect(subject).to respond_to(:top_up) }
      it { expect { subject.top_up(10) }.to change { subject.balance }.by(10) }
      it { expect { subject.top_up(100) }.to raise_error(["cannot top up",
                                                         "max balance of",
                                                         "£#{Oyster::MAXIMUM_BALANCE}",
                                                         'reached'].join(' ')) }
    end
  end
  context 'Feature 3 - Tap in' do
    describe '#tap_in' do
      after(:each) { subject.tap_out }
      it { expect(subject).to respond_to(:tap_in).with(1).argument }
      it { expect { subject.tap_in(station) }.to(change { subject.in_journey? }) }
      it 'raises an error when tapping in with < 1.00 balance' do
        subject.balance = 0
        expect { subject.tap_in }.to raise_error 'Please top up'
        expect(subject.in_journey?).to eq(false)
      end
      it { expect { subject.tap_in(station) }.to change { subject.entry_station }.to(station) }
    end
  end
  context 'Feature 4 - Tap out' do
    describe '#tap_out' do
      before(:each) { subject.tap_out; subject.balance = 10 }
      it { expect(subject).to respond_to(:tap_out).with(1).argument }
      it { expect(subject.in_journey?).to eq(false) }
      it 'can charge the customer when journey is finished' do
        expect { subject.tap_out }.to change { subject.balance }.by(-1)
      end
      it 'removes entry station on tap out' do
        subject.tap_in(station)
        expect { subject.tap_out(station) }.to change { subject.entry_station }.to(nil)
      end
    end
  end
  context 'Feature 5 - In Journey' do
    describe '#in_journey?' do
      it { expect(subject).to respond_to(:in_journey?) }
      it { expect(subject.in_journey?).to be(true).or be(false) }
    end
  end
  context 'Feature 6 - Stations' do
    describe '#entry_station' do
      it { expect(subject).to respond_to(:entry_station) }
      it { expect(subject.entry_station).to eq(nil) }
    end
    describe '#exit_stations' do
      it { expect(subject).to respond_to(:exit_station) }
      it 'exit station changes on tap out' do
        subject.tap_out(station)
        expect(subject.exit_station).to eq(station)
      end
    end
  end
  context 'Feature 7 - Travel History' do
    describe '#travel_history' do
      it { expect(subject).to respond_to(:travel_history) }
      it { expect(subject).to respond_to(:add_journey) }
    end
  end
end
