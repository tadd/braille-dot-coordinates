require_relative 'braille-dot-coordinates/converter'
require_relative 'braille-dot-coordinates/table'

module BrailleDotCoordinates
  module_function
  def convert(string, option = {})
    Converter.new(option).convert(string)
  end
end
