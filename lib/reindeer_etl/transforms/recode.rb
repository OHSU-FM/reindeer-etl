module ReindeerETL::Transforms
    class Recode
        def initialize opts={}
            @cols = (opts[:cols] || []).map{|v|v.to_s}
            @codes = opts[:codes] || {}
            @ignore_vals = (opts[:ignore] || []).map{|v|v.to_s}
            @ignore_all = (opts[:ignore_all] || false)
            @error_on_unknown = !@ignore_all

            raise ArgumentError.new(':cols array must be specified') if @cols.empty?
            raise ArgumentError.new(':codes must be specified') if @codes.empty?
            @cols = @cols.to_set
            @acceptable_keys = (@codes.keys + @ignore_vals).to_set
            @counter = 0
        end
       
        def process row
            # Raise error unless all columns are present
            old_row  = row.dup
            rset = row.keys.to_set
            unless @cols.subset?(rset)
                m_cols = @cols - rset
                raise ReindeerETL::Errors::RecordInvalid.new("Missing columns: #{m_cols.to_a}")
            end

            # Run recode
            @cols.each do |col| 
                val = row[col]
                _validate_val(val)
                _update_row(row, col, val)
            end

            @counter += 1
            row
        end
        
        private

        def _validate_val(val)
            if @error_on_unkown && !@any_val.include?(val)
                # Raise error if we don't recognize this value
                raise ReindeerETL::Errors::RecordInvalid.new("Bad value: #{val}")
            end
        end
        
        def _update_row(row, col, val)
            if @acceptable_keys.include? val
                row[col] = @codes[val] if @codes.has_key?(val)
            elsif @error_on_unknown
                binding.pry
                pp self
                raise ReindeerETL::Errors::RecordInvalid.new("Invalid value in recode: row# #{@counter} {#{col}:#{val}}")
            end
        end

    end
end
