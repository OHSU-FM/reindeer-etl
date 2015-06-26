module ReindeerWaterworks::Transforms
    ##
    # Swap out old error codes with REP_CODE, add new columns with error codes
    class ResponseStatus
        ERROR_CODES = [ 222, 444, 555, 777, 888, 998, 999 ].map{|v|v.to_s}
        NO_CODE = 111 
        # What to replace a code with if one is found
        REP_CODE = '{question_not_shown}'

        def initialize opts={}
            @ignore_cols = opts[:ignore] || []
        end
        
        def process(row)
            binding.pry
            (row.keys - @ignore_cols).each do |k|
                val = row[k]
                if _has_code?(val)
                    row[k] = REP_CODE
                    ecode = val
                else
                    ecode = NO_CODE
                end

                row["responseStatus_#{k}"] = "E#{ecode}E"
            end
            row
        end

        def _has_code val
            ERROR_CODES.include?(val.to_s)
        end

    end
end
