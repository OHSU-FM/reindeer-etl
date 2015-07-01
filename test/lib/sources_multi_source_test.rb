require 'minitest_helper'

describe ReindeerETL::Sources::MultiSource do
    it 'must merge data from multiple sources' do
        klass = ReindeerETL::Sources::CSVSource
        path1 = "#{$dir}/fixtures/comma_delimited.csv" 
        path2 = "#{$dir}/fixtures/comma_delimited_join_on_a.csv" 
        source = ReindeerETL::Sources::MultiSource.new('a', [path1, path2], :klass=>klass)
        rows = []
        keys = %w[a b c d e f g h i j k l]
        source.each do |row|
            rows.push row
            row.keys.must_equal keys
        end
        rows.count.must_equal 13
    end

end


