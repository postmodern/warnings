require 'warnings/warning'
require 'warnings/warnings'

module Warnings
  module Mixin
    #
    # Registers a warning.
    #
    # @param [String] message
    #   The warning message.
    #
    # @example
    #   warn "Foo#bar method will be removed in 1.0.0"
    #
    # @return [nil]
    #
    def warn(message)
      super(message) if $DEBUG

      $WARNINGS << Warning.new(message,caller)
      return nil
    end
  end
end
