require './lib/Oyster'
describe Oyster do
  context 'Feature 1 - Balance' do
    describe '#balance' do
      it { expect(subject).to respond_to(:balance) }
    end
  end
  context 'Feature 2 - Top Up' do
    describe '#top_up' do
      before(:each) { subject.top_up(1.00) }
      it { expect(subject).to respond_to(:top_up).with(1).argument }
      it { expect(subject.balance).to eq(1.0) }
      it 'raises error if too much is topped up' do
        max_bal = Oyster::MAXIMUM_BALANCE
        expect { subject.top_up(100) }.to raise_error(['cannot top up',
                                                       'max balance of',
                                                       "#{max_bal}",
                                                       'reached'].join(' '))
      end
    end
  end
  context 'Feature 3 - Deduct' do
    describe '#deduct' do
      before(:each) { subject.balance = 10.00 }
      it { expect(subject).to respond_to(:deduct).with(1).argument }
      it 'can deduct money from the card' do
        subject.deduct(1.00)
        expect(subject.balance).to eq(9.0)
      end
      it 'raises an error if not enough money availible' do
        expect { subject.deduct(100) }.to raise_error(['cannot deduct',
                                                       'not enough money',
                                                       'on card'].join(' '))
      end
    end
  end
  context 'Feature 4 - Tap in' do
    describe '#tap_in' do
      before(:each) { subject.tap_in }
      it { expect(subject).to respond_to(:tap_in).with(1).argument }
      it { expect(subject.in_journey).to eq(true) }
    end
  end
  context 'Featre 5 - Tap out' do
    describe '#tap_out' do
      before(:each) { subject.tap_out }
      it { expect(subject).to respond_to(:tap_out).with(1).argument }
      it { expect(subject.in_journey).to eq(false) }
    end
  end
  context 'Feature 6 - In Journey' do
    describe '#in_journey?' do
      it { expect(subject).to respond_to(:in_journey) }
      it { expect(subject.in_journey).to be(true).or be(false) }
    end
  end
end
