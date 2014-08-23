# -*- coding: utf-8 -*-

# size is taken from:
# http://www.jtr-tenji.co.jp/document/l-size.pdf

require_relative 'table'

module BrailleDotCoordinates
  class Converter
    # in micro meter
    CODE_TO_COORDINATES_UM = {
      1 => [2000, 2250],
      2 => [2000, 2250*2],
      3 => [2000, 2250*3],
      4 => [2000*2, 2250],
      5 => [2000*2, 2250*2],
      6 => [2000*2, 2250*3]
    }
    DEFAULT_OPTION = {
      unit: :um,
      type: :integer
    }

    def initialize(option = {})
      option = DEFAULT_OPTION.merge(option)
      @unit = option[:unit]
      @type = option[:type]
    end

    # FIXME!!!: 2nd or later characters don't have correct coordinates
    def convert(string)
      string.scan(/./).map do |ch|
        convert_character(ch)
      end
    end

    def convert_character(ch)
      return nil if ch == ' '
      raise ConverterError, "non-braille charactor given: '#{ch}'" unless self.class.braille?(ch)
      code = ::BrailleDotCoordinates::Table::CHAR_TO_CODE[ch]
      CODE_TO_COORDINATES_UM.map do |nth, coordinates|
        (code & (1 << (nth-1))).nonzero? ? coordinates : nil
      end.compact
    end

    def self.braille?(ch)
      ::BrailleDotCoordinates::Table::CHAR_TO_CODE.keys.include?(ch)
    end
  end
end
