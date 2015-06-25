module ReindeerWaterworks::Transforms
    ##
    # A simple transform that renames columns
    class Renamer
        def initialize cols={}
            @cols = cols
        end

        def process(row)
            @cols.keys.each do |k|
                row[k] row.delete(@cols[k])
            end
        end
    end

end
