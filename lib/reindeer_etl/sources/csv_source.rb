require 'csv'

module ReindeerETL::Sources
    class CSVSource < BaseSource
        def initialize path, opts = {}
            @path = path
            @opts = {headers: true, header_converters: :symbol}.merge opts
        end
            
        def each
            CSV.foreach(@path, @opts) do |row|
                row = row.to_hash
                @only_cols
                yield(row.to_hash.each{|v|})
            end
        end
    end
end

