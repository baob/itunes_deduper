require 'lib/deduper'

del_dir = Dir.getwd

totals = Deduper.dedupe(del_dir)

puts "\nTotals: #{totals.inspect}"
