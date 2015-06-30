module ReindeerETL::Transforms
    ##
    # Swap out old error codes with REP_CODE, add new columns with error codes
    class ResponseStatus
        ERROR_CODES = %w{222 444 555 777 888 998 999}
        NO_CODE = '111'
        
        # What to replace a code with if one is found
        REP_CODE = '{question_not_shown}'
        REP_COL_PREFIX = 'responseStatus_'
        
        def initialize opts={}
            @except_cols = (opts[:except] || []).to_set
        end
        
        def process(row)
            row_keys = row.keys.to_set
            unless @except_cols.subset? row_keys
                x_cols = (@except_cols - row_keys).to_a
                raise ReindeerETL::Errors::RecordInvalid.new("Missing except keys: #{x_cols}")
            end
            (row_keys - @except_cols).each do |k|
                new_col = "#{REP_COL_PREFIX}#{k.gsub('_','')}" 
                if row_keys.include? new_col 
                    raise ReindeerETL::Errors::RecordInvalid.new("Column #{new_col} already exists")
                end
                val = row[k]
                if _has_code?(val)
                    row[k] = REP_CODE
                    ecode = val.to_s
                else
                    ecode = NO_CODE
                end
                row[new_col] = "E#{ecode}E"
            end
            row
        end
        
        private
        def _has_code? val
            ERROR_CODES.include?(val.to_s)
        end
    end
end
