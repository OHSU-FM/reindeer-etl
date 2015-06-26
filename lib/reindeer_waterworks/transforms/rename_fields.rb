module ReindeerWaterworks::Transforms
    ##
    # A simple transform that renames columns
    class RenameFields
        def initialize cols
            @cols = cols
        end
        
        def process(row)
            @cols.keys.each do |k, v|
                binding.pry
                row[v.to_sym] = row.delete(k)
                row
            end
        end
    end

end
