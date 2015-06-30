require 'csv'

module ReindeerETL::Destinations
    class CSVDest
        def initialize(output_file, delimiter=',')
          @csv = CSV.open(output_file, 'w', {col_sep: delimiter})
        end
        
        def write(row)
          unless @headers_written
            @headers_written = true
            @csv << row.keys
          end
          @csv << row.values
        end
        
        def close
          @csv.close
        end
    end
end
