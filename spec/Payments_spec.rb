require './lib/Payments'
require './lib/Oyster'

describe PaymentProcessor do
  let(:card) { Oyster.new }
  context 'Feature 1 - Top Up' do
    describe '#pay' do
      before(:each) { subject.pay(100, card) }
      it { expect(subject).to respond_to(:pay).with(2).argument }
      it { expect(card.balance).to eq(100) }
      it 'raises error if too much is topped up' do
        expect { subject.pay(10000, card) }.to raise_error(['cannot top up',
                                                          'max balance of',
                                                          "£#{Oyster::MAXIMUM_BALANCE}",
                                                          'reached'].join(' '))
      end
    end
  end
  context 'Feature 2 - Deduct' do
    describe '#deduct' do
      before(:each) { card.balance = 1000 }
      it { expect(subject).to respond_to(:deduct).with(2).argument }
      it 'can deduct money from the card' do
        expect { subject.deduct(100, card) }.to change { card.balance }.by(-100)
      end
      it 'raises an error if not enough money availible' do
        expect { subject.deduct(10000, card) }.to raise_error(['cannot deduct',
                                                             'not enough money',
                                                             'on card'].join(' '))
        expect(card.balance).to eq(1000)
      end
    end
  end
end
