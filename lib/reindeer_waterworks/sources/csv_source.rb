require 'csv'

module ReindeerWaterworks::Sources
    class CSVSource
        def initialize path, opts = {}
            @path = path
            @opts = {headers: true, header_converters: :symbol}.merge opts
        end
            
        def each
            CSV.foreach(@path, @opts) do |row|
                yield(row.to_hash)
            end
        end
    end
end

