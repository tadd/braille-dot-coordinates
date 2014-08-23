# -*- coding: utf-8 -*-

require_relative '../lib/braille-dot-coordinates'

describe BrailleDotCoordinates do
  describe '.convert' do
    it 'converts' do
      expect(described_class.convert('⠁')).to eq [ # string
                                                  [ # char
                                                   [2000, 2250]]]
    end
  end
end
