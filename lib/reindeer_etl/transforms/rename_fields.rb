module ReindeerETL::Transforms
    ##
    # A simple transform that renames columns
    class RenameFields
        def initialize cols
            @cols = cols
        end
        
        def process(row)
            counter=0
            @cols.each do |k, v|
                next if k == v
                row[v.to_sym] = row.delete(k.to_sym)
            end
            row
        end
    end

end
