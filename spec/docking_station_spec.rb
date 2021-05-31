require 'docking_station'

describe DockingStation do
  let (:bike) {double :bike}

  it { is_expected.to respond_to :release_bike }

  describe '#release_bike' do
    it 'releases a bike' do
      bike = double(:bike)
      allow(bike).to receive(:status=)
      allow(bike).to receive(:working?) { true }
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  describe '#dock(bike)' do
    it 'raises an error when full' do
      bike = double(:bike)
      allow(bike).to receive(:status=)
      subject.capacity.times {subject.dock bike}
      expect { subject.dock bike }.to raise_error 'Docking station full'
    end


  end

  it 'docks something' do
    bike = double(:bike)
    allow(bike).to receive(:status=)
    expect(subject.dock(bike)).to eq [bike]
  end

  #it 'returns docked bikes' do
    #bike = Bike.new
    #expect(subject.bikes).to eq [bike]
    #subject.dock(bike)
  #end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'initialization' do
    it 'has a variable capacity' do
      bike = double(:bike)
      allow(bike).to receive(:status=)
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock bike }
      expect{ docking_station.dock bike }.to raise_error 'Docking station full'
    end

    subject { DockingStation.new }
    it 'defaults capacity' do
      bike = double(:bike)
      allow(bike).to receive(:status=)
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect{ subject.dock(bike) }.to raise_error 'Docking station full'
    end
  end

  it 'allows user to report bike as broken when docking' do
    bike = double(:bike)
    allow(bike).to receive(:status=)
    allow(bike).to receive(:working?) {false}
    subject.dock(bike, 'broken')
    expect(bike.working?).to eq false
  end

  it 'does not release bike if it is broken' do
    bike = double(:bike)
    allow(bike).to receive(:status=)
    allow(bike).to receive(:working?) {false}
    subject.dock(bike, 'broken')
    expect{subject.release_bike}.to raise_error 'Bike is broken'
  end

end