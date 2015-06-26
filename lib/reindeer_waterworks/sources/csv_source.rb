require 'csv'

module ReindeerWaterworks::Sources
    class CSVSource
        def initialize path, col_sep = ','
            @csv = CSV.open(path, 'r', {headers: true, header_converters: :symbol, col_sep: col_sep})
        end
    
        def each
            @csv.each do |row|
                yield(row.to_hash)
            end
            @csv.close
        end
    end
end

