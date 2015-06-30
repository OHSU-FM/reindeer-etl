module ReindeerETL::Transforms
    class Recode
        def initialize opts={}
            @cols = opts[:cols] || []
            @codes = opts[:codes] || {}
            @ignore_vals = opts[:ignore] || []
            raise ArgumentError.new(':cols array must be specified') if @cols.empty?
            raise ArgumentError.new(':codes must be specified') if @codes.empty?
            @cols = @cols.to_set
            @any_val = (@codes.keys + @ignore_vals).to_set
        end
        
        def process row
            binding.pry
            # Raise error unless all columns are present
            unless @cols.subset?(row.keys.to_set)
                raise ReindeerETL::Errors::RecordInvalid.new('Missing columns')
            end
            # Run recode
            @cols.each do |col|
                # Invalid value
                unless @any_val.include?(row[col])
                    raise ReindeerETL::Errors::RecordInvalid.new('Bad value')
                end
                val = row[col]
                unless @ignore_vals.include?(val)
                    row[col] = @codes[val]
                end
            end
            row
        end
    end
end
