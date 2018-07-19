require './lib/Station'
describe Station do
  let(:subject) { Station.new({:name => 'defaul station', :zone => 1}) }
  context 'Feature 1 : station name' do
    describe '#name' do
      it { expect(subject).to respond_to(:name) }
    end
  end
  context 'Feature 2 : station zone' do
    describe '#zone' do
      it { expect(subject).to respond_to(:name) }
    end
  end
end
