# -*- coding: utf-8 -*-

require_relative '../../lib/braille-dot-coordinates/converter'

describe BrailleDotCoordinates::Converter do
  describe '.braille?' do
    context 'braiile character given' do
      it 'return true' do
        expect(described_class.braille?('⠁')).to be_truthy
      end
    end

    context 'non-braiile character given' do
      it 'return false' do
        expect(described_class.braille?(' ')).to be_falsy
      end
    end
  end

  describe '#convert_character' do
    subject { described_class.new }

    it 'converts braille character to coordinates' do
      expect(subject.convert_character('⠁')).to eq [[2000, 2250]]
      expect(subject.convert_character('⠿')).to eq [[2000, 2250],
                                                    [2000, 2250*2],
                                                    [2000, 2250*3],
                                                    [2000*2, 2250],
                                                    [2000*2, 2250*2],
                                                    [2000*2, 2250*3]]
    end

    context 'space given' do
      it 'converts as empty corrdinates' do
        expect(subject.convert_character(' ')).to eq []
      end
    end
  end

  describe '#convert' do
    subject { described_class.new }

    it 'converts braille string to coordinates' do
      expect(subject.convert('⠁⠁')).to eq [[[2000, 2250]],
                                            [[2000 + 5200, 2250]]]
    end

    it 'converts string with space' do
      expect(subject.convert('⠁ ⠁')).to eq [[[2000, 2250]],
                                             [],
                                             [[2000 + 5200*2, 2250]]]
    end
  end
end
