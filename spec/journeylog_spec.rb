require './lib/journeylog'
require './lib/journey'
describe JourneyLog do
  let (:jl) { JourneyLog.new(Journey) }
  let(:station) { double 'station'}
  context 'Feature 0 - Journey list' do
    describe '#journey_list' do
      it { expect(jl).to respond_to(:journey_list)}
    end
  end
  context 'Feature 1 - Start Journey' do
    describe '#journey_list' do
      it { expect(jl).to respond_to(:start_journey).with(1).arguments }
    end
  end
  context 'Feature 2 - Finish Journey' do
    describe '#finish_journey' do
      it { expect(jl).to respond_to(:finish_journey).with(1).arguments }
      it { expect { jl.finish_journey(:station) }.to(change { jl.journey_list.length })}
    end
  end
  context 'Feature 2 - Current Journey' do
    describe '#current_jouney' do
      it { expect(jl.send(:current_journey)).to be_a(Journey) }
    end
  end
  context 'Feature 3 - Return Journeys' do
    describe '#return_list' do
      it { expect(jl).to respond_to(:return_list) }
      it { expect(jl.journey_list).to be_an(Array) }
    end
  end
  context 'Simulation tests' do
    describe 'Simulate a single journey' do
      it { expect(jl.journey_list.length).to eq(0) }
      it 'works on tap in' do
        jl.start_journey(:station)
        jl.finish_journey(:station)
        expect(jl.journey_list.length).to eq(2)
        expect(jl.journey_list.last).to be_a(Journey)
      end
    end
    describe 'Simulate an incomplete journey' do
      it 'still works if journey is incomplete' do
        jl.start_journey(:station)
        expect(jl.journey_list.length).to eq(1)
        jl.start_journey(:station)
        expect(jl.journey_list.length).to eq(2)
      end
    end
  end
end