module ReindeerETL::Transforms
    ##
    # A simple transform that renames columns
    class RenameFields
        def initialize cols
            @cols = cols
        end
        
        def process(row)
            counter=0
            row_keys = row.keys.map{|v|v.to_s}.to_set
            req_keys = @cols.keys.map{|v|v.to_s}.to_set

            # raise an error unless all of req is in row
            unless req_keys.subset?(row_keys)
                binding.pry
                raise ReindeerETL::Errors::RecordInvalid.new('Missing columns in rename')
            end
            @cols.each do |k, v|
                next if k == v
                row[v.to_sym] = row.delete(k.to_sym)
            end
            row
        end
    end

end
