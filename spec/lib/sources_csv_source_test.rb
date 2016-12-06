require 'minitest_helper'

def loads_as_hash path, opts={}
    source = ReindeerETL::Sources::CSVSource.new(path, opts)
    counter = 0
    source.each do |row|
       row.keys.must_equal %w{a b c d e f g h i}
       counter += 1
       counter.must_equal row['a'].to_i
    end
    counter.must_equal 13 
end

describe ReindeerETL::Sources::CSVSource do
    it 'must yield each line of a csv file as a hash' do
        path = "#{$dir}/fixtures/comma_delimited.csv" 
        loads_as_hash(path, :col_sep=>',')
    end

    it 'must yield each line of a tabbed csv file as a hash' do
        path = "#{$dir}/fixtures/tab_delimited.csv" 
        loads_as_hash(path, :col_sep=>"\t")
    end
end
