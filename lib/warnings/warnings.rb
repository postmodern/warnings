module Warnings
  # The global list of warnings
  $WARNINGS ||= []

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
  def self.from_file(path)
    if File.extname(path).empty?
      # default the file extension to `.rb`
      path = "#{path}.rb"
    end

    $WARNINGS.select do |warning|
      (warning.source_file == path) ||
      warning.source_file.end_with?("/#{path}")
    end
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
                name = name.to_s

                lambda { |warning| warning.source_method == name }
              end

    $WARNINGS.select(&selector)
  end
end
