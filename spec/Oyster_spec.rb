require './lib/Oyster'
describe Oyster do
  before(:each) { subject.balance = 100 }
  let(:station) { double :station }
  context 'Feature 1 - Balance' do
    describe '#balance' do
      it { expect(subject).to respond_to(:balance) }
      it { expect(defined? Travel::MAXIMUM_BALANCE).to eq('constant') }
    end
    describe '#see_balance' do 
      before(:each) { subject.balance = 0 }
      it { expect(subject).to respond_to(:see_balance) }
      it 'can display balance correctly' do
        subject.balance = 550
        expect(subject.see_balance).to eq('£5.50')
      end
      it { expect(subject.see_balance).to eq('£0.00')}
    end
  end
  context 'Feature 2' do
    describe '#top-up' do
      it { expect(subject).to respond_to(:top_up) }
      it { expect { subject.top_up(1000) }.to change { subject.balance }.by(1000) }
      it { expect { subject.top_up(10000) }.to raise_error(["cannot top up",
                                                         "max balance of",
                                                         "£#{Oyster::MAXIMUM_BALANCE}",
                                                         'reached'].join(' ')) }
    end
  end
  context 'Feature 3 - Tap in' do
    describe '#tap_in' do
      before(:each) { subject.balance = 500 ; subject.tap_out(station) }
      it { expect(subject).to respond_to(:tap_in).with(1).argument }
      it 'raises an error when tapping in with < 100 balance' do
        subject.balance = 0
        expect { subject.tap_in(station) }.to raise_error 'Please top up'
      end
    end
  end
  context 'Feature 4 - Tap out' do
    describe '#tap_out' do
      before(:each) { ; subject.balance = 1000 ; subject.tap_out(station)}
      it { expect(subject).to respond_to(:tap_out).with(1).argument }
      it 'can charge the customer when journey is finished' do
        expect(subject.balance).to_not eq(1000)
      end
      it 'affects history corretly on tap out' do
        expect(subject.travel_history).to_not eq([])
      end
      it { expect(subject.travel_history.last).to be_a(Journey) }
    end
  end
  context 'Feature 5 - Travel History' do
    describe '#travel_history' do
      it { expect(subject).to respond_to(:travel_history) }
    end
  end
end
describe Oyster do
  before(:each) { subject.balance = 1000 }
  let(:station) { double :station }
  context 'Run-Time-Tests' do
    describe 'Oyster can deduct penalty fare appropriatly' do
      it 'does not penalise when it shouldnt' do
        subject.tap_in(:station)
        subject.tap_out(:station)
        subject.tap_in(:station)
        expect(subject.balance).to eq(800)
      end
    end
  end
end