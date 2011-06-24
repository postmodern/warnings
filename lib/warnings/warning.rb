module Warnings
  class Warning

    # The warning message
    attr_reader :message

    # The backtrace to the warning
    #
    # @return [Array<String>]
    #   The raw backtrace.
    #
    attr_reader :backtrace

    # The source location of the warning.
    #
    # @return [Array<path, line>]
    #   The path and line number where the warning originated.
    #
    attr_reader :source_location

    # The source method of the warning.
    #
    # @return [Symbol]
    #   The method name.
    #
    attr_reader :source_method

    #
    # Creates a new warning.
    #
    # @param [String] message
    #   The warning message.
    #
    # @param [Array<String>] backtrace
    #   The backtrace of the warning.
    #
    def initialize(message,backtrace)
      @message = message
      @backtrace = backtrace

      file, line, context = @backtrace.first.split(':',3)

      @source_location = [file, line.to_i]
      @source_method = context[5..-2] if context
    end

    #
    # The source file of the warning.
    #
    # @return [String]
    #   The path of the file.
    #
    def source_file
      @source_location[0]
    end

    #
    # The source line of the warning.
    #
    # @return [Integer]
    #   The line-number of the warning.
    #
    def source_line
      @source_location[1]
    end

    #
    # Compares the warning message to a pattern.
    #
    # @param [Regexp] pattern
    #   The pattern to match against.
    #
    # @return [Integer, nil]
    #   The index of the pattern match within the warning message.
    #
    def =~(pattern)
      @message =~ message
    end

    #
    # Compares the warning to another warning.
    #
    # @param [Warning] other
    #   The other warning to compare against.
    #
    # @return [Boolean]
    #   Specifies whether the two warnings represent the same message.
    #
    def ==(other)
      (@message == other.message) &&
      (@source_location == other.source_location) &&
      (@source_method == other.source_method)
    end

    #
    # Compares the warning to another warning.
    #
    # @param [Warning] other
    #   The other warning to compare against.
    #
    # @return [Boolean]
    #   Specifies whether the two warnings represent the same message.
    #
    def ===(other)
      case other
      when Warning
        self == other
      when Regexp, String
        !(@message.match(other).nil?)
      else
        false
      end
    end

    #
    # Converts the warning to a String.
    #
    # @return [String]
    #   The warning message.
    #
    def to_s
      @message.to_s
    end

    #
    # Formats a warning.
    #
    # @return [String]
    #   The printable warning.
    #
    # @note
    #   Will include ANSI color codes, only if `STDOUT` is a TTY Terminal.
    #
    def print
      trace = unless $DEBUG
                @backtrace[0,10]
              else
                @backtrace
              end

      if $stderr.tty?
        $stderr.puts "\e[33m#{@message}:\e[0m"
        trace.each { |line| $stderr.puts "\t\e[2m#{line}\e[0m" }
      else
        $stderr.puts "#{@message}:"
        trace.each { |line| $stderr.puts "\t#{line}" }
      end
    end

    #
    # Inspects the warning.
    #
    # @return [String]
    #   The inspected {#source_file}, {#source_line} and {#message}.
    #
    def inspect
      if @source_method
        "#{source_file}:#{source_line} (#{@source_method}): #{@message}"
      else
        "#{source_file}:#{source_line}: #{@message}"
      end
    end

  end
end
