require './lib/Oyster'
describe Oyster do
  before(:each) { subject.balance = 1.00 }
  context 'Feature 1 - Balance' do
    describe '#balance' do
      it { expect(subject).to respond_to(:balance) }
    end
  end
  context 'Feature 2 - Tap in' do
    describe '#tap_in' do
      before(:each) { subject.tap_in }
      it { expect(subject).to respond_to(:tap_in).with(1).argument }
      it { expect(subject.in_journey).to eq(true) }
      it 'raises an error when tapping in with < 1.00 balance' do
        subject.balance = 0
        expect { subject.tap_in }.to raise_error 'Please top up'
      end
    end
  end
  context 'Featre 3 - Tap out' do
    describe '#tap_out' do
      before(:each) { subject.tap_out; subject.balance = 10 }
      it { expect(subject).to respond_to(:tap_out).with(1).argument }
      it { expect(subject.in_journey).to eq(false) }
      it 'can charge the customer when journey is finished' do
        expect { subject.tap_out }.to change { subject.balance }.by(-1)
      end
    end
  end
  context 'Feature 4 - In Journey' do
    describe '#in_journey?' do
      it { expect(subject).to respond_to(:in_journey) }
      it { expect(subject.in_journey).to be(true).or be(false) }
    end
  end
end
