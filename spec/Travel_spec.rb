require './lib/Travel'
describe Travel do
  context 'Constants' do
    describe '#MAXIMUM_BALANCE' do
      it { expect(defined? Travel::MAXIMUM_BALANCE).to eq('constant') }
      it { expect(defined? Travel::MINIMUM_CHARGE).to eq('constant') }
      it { expect(defined? Travel::STARTING_BALANCE).to eq('constant') }
      it { expect(defined? Travel::ZONES).to eq('constant') }
    end
  end
end
