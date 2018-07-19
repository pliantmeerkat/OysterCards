require './lib/journey'
require './lib/Payments'
describe Journey do
  let(:station) { double :station, zone: 1 }
  let(:jny) { Journey.new }
  context 'Feature 1 - Entrance station' do
    describe '#entry_add' do
      before(:each) { jny.entry_station(station) }
      it { expect(jny).to respond_to(:entry_station).with(1).argument }
      it { expect(jny.entry_station(station)).to eq(station) }
      it { expect(jny.complete_journey(station)).to eq(false) }
      it { expect(jny.current_journey[:entry]).to eq(station) }
    end
  end
  context 'Feature 2 - Exit station' do
    describe '#exit_add' do
      it { expect(jny).to respond_to(:exit_station) }
      it { expect(jny.exit_station).to eq(nil) }
    end
  end
  context 'Feature 3 - complete journey' do
    describe '#complete_journey' do
      before(:each) { jny.complete_journey(station) }
      it { expect(jny).to respond_to(:complete_journey).with(1).arguments }
      it { expect(jny.complete_journey(station)).to eq(true) }
      it { expect(jny.exit_station).to eq(station) }
    end
  end
  context 'Feature 4 - Charge Customer' do
    describe '#charge_fee' do
      it { expect(jny).to respond_to(:charge_fee) }
    end
  end
  context 'Feature 5 - Penalty Fare' do
    describe '#penalty_charge' do
      before(:each) { jny.entry_station(station) }
      it { expect(jny).to respond_to(:penalty_charge) }
      it { expect(jny.penalty_charge).to eq(600)}
    end
  end
end
