require 'warnings/version'
require 'warnings/warnings'
require 'warnings/mixin'

include Warnings::Mixin

at_exit do
  if (!$WARNINGS.empty? && ($VERBOSE || $DEBUG))
    STDERR.puts
    STDERR.puts "Warnings:"
    STDERR.puts

    $WARNINGS.each { |warning| STDERR.puts "  #{warning.format}" }

    STDERR.puts
  end
end
