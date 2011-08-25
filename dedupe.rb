require 'lib/dedupedir'

testdir1 = 'C:\Users\suzie\Music\suzies music collection\Adam Holzman\Antonio Lauro_ Venezuelan Waltzes For Gu'
testdir2 = 'C:\Users\suzie\Music\suzies music collection\Adam Holzman'
testdir3 = 'C:\Users\suzie\Music\suzies music collection'
testdir4 = 'C:\Users\suzie\Music\suzies music collection\Various Artists\Guitar Adagios'


totals = Dedupedir.dedupe(testdir3)

puts "\nTotals: #{totals.inspect}"
