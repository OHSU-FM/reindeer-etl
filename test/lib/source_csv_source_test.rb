require 'minitest_helper'

def loads_as_hash path, opts={}
    source = ReindeerWaterworks::Sources::CSVSource.new(path, opts)
    counter = 0
    source.each do |row|
       row.keys == ['a','b','c','d','e','f','g', 'h', 'i']  
       counter += 1
    end
    counter.must_equal 13 
end

describe ReindeerWaterworks::Sources::CSVSource do
    it 'must yield each line of a csv file as a hash' do
        path = "#{$dir}/fixtures/comma_delimited.csv" 
        loads_as_hash(path)
    end

    it 'must yield each line of a tabbed csv file as a hash' do
        path = "#{$dir}/fixtures/tab_delimited.csv" 
        loads_as_hash(path)
    end
end
