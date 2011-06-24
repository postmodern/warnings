require 'warnings/version'
require 'warnings/warnings'
require 'warnings/mixin'

include Warnings::Mixin

at_exit do
  if (!$WARNINGS.empty? && ($VERBOSE || $DEBUG))
    $stderr.puts
    $stderr.puts "Warnings:"
    $stderr.puts

    unique_warnings = {}

    $WARNINGS.each do |warning|
      unique_warnings[warning.source_location] ||= warning
    end

    unqiue_warnings.each { |warning| warning.print }

    $stderr.puts
  end
end
