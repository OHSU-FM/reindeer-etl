require 'csv'

module ReindeerETL::Sources
    class CSVSource < BaseSource
        def initialize path, opts = {}
            super
            @csv_opts = {headers: true}.merge opts
        end
            
        def each
            CSV.foreach(@path, @csv_opts) do |row|
                row = row.to_hash
                simple_transforms(row)
                yield(row)
            end
        end
    end
end
