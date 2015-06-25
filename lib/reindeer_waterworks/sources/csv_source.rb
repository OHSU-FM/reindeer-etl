require 'csv'

module ReindeerWaterworks::Sources
    class CSVSource
        def initialize path
            @csv = CSV.open(path, headers: true, header_converters: :symbol)
        end
    
        def each
            @csv.each do |row|
                yield(row.to_hash)
            end
            @csv.close
        end
    end
end

