require './lib/Oyster'
describe Oyster do
  context 'Feature 1 - Balance' do
    describe '#balance' do
      it { expect(subject).to respond_to(:balance) }
    end
  end
  context 'Feature 2 - Top Up' do
    describe '#top_up' do
      before (:each) { subject.top_up(1.00) }
      it { expect(subject).to respond_to(:top_up).with(1).arguments }
      it { expect(subject.balance).to eq(1.0) }
      it 'raises error if too much is topped up' do
        max_bal = Oyster::MAXIMUM_BALANCE
        expect { subject.top_up(100) }.to raise_error(['cannot top up',
                                                      'max balance of',
                                                      "#{max_bal}",
                                                      'reached'].join(" "))
      end
    end
  end
end

