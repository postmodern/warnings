module Warnings
  # The global list of warnings
  $WARNINGS ||= []

  at_exit do
    if (!$WARNINGS.empty? && ($VERBOSE || $DEBUG))
      $stderr.puts
      $stderr.puts 'Warnings:'
      $stderr.puts

      unique_warnings = {}

      $WARNINGS.each do |warning|
        unique_warnings[warning.source_location] ||= warning
      end

      unique_warnings.each_value { |warning| warning.print }

      $stderr.puts
    end
  end

  #
  # Selects all warnings with a similar message.
  #
  # @param [String, Regexp] pattern
  #   The message pattern to search for.
  #
  # @return [Warning]
  #   The warnings from the sub-path.
  #
  def self.grep(pattern)
    $WARNINGS.select { |warning| warning.message.match(pattern) }
  end

  #
  # Selects all warnings originating from a file.
  #
  # @param [String] path
  #   The sub-path to search for.
  #
  # @return [Warning]
  #   The warnings from the sub-path.
  #
  def self.from(path)
    $WARNINGS.select { |warning| warning.source_file.include?(path) }
  end

  #
  # Selects all warnings originating from a method.
  #
  # @param [Regexp, String] name
  #   The method name or pattern to search for.
  #
  # @return [Warning]
  #   The warnings from the specified method.
  #
  def self.from_method(name)
    selector = case name
              when Regexp
                lambda { |warning| warning.source_method =~ name }
              else
                lambda { |warning| warning.source_method == name }
              end

    $WARNINGS.select(&selector)
  end
end
