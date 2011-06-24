require 'warnings/warning'
require 'warnings/warnings'

module Warnings
  module Mixin
    #
    # Enables or disables warnings.
    #
    # @param [Boolean] mode
    #   Specifies whether warnings will be enabled or disabled.
    #
    # @return [Boolean]
    #   Specifies whether warnings are enabled.
    #
    def warnings=(mode)
      @warnings = mode
    end

    #
    # Determines whether warnings are enabled.
    #
    # @return [Boolean]
    #   Specifies whether warnings are enabled.
    #
    # @note
    #   Enabling `$VERBOSE` (`ruby -w`) or `$DEBUG` (`ruby -d`) will
    #   enable all warnings by default.
    #
    def warnings?
      ($VERBOSE || $DEBUG) || (@warnings != false)
    end

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
      if warnings?
        super(message) if $DEBUG

        $WARNINGS << Warning.new(message,caller)
      end

      return nil
    end
  end
end
