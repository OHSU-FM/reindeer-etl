require 'minitest_helper'

describe ReindeerETL::Sources::MultiSource do
    it 'must merge data from multiple sources' do
        klass = ReindeerETL::Sources::CSVSource
        path1 = "#{$dir}/fixtures/comma_delimited.csv" 
        path2 = "#{$dir}/fixtures/comma_delimited_join_on_a.csv" 
        source = ReindeerETL::Sources::MultiSource.new('a', [path1, path2], :klass=>klass)
        rows = []
        source.each do |row|
            rows.push row
        end
        puts rows
    end

end


