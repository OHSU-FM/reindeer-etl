require 'set'

module ReindeerETL::Sources
    class BaseSource
        def initialize path, opts={}
            @path = path
            @only_cols = opts.delete(:only) || []
            @require_cols = opts.delete(:require) || []
        end
       
        ## 
        # Configurable transforms in source
        def process row
            only_cols(row) unless @only_cols.empty?
            require_cols(row) unless @require_cols.empty?
            row
        end

        ##
        # Filter out everything except these columns
        def only_cols dict
            (dict.keys -  @only_cols).each{|col|dict.delete(col)}
            dict
        end

        ## 
        # require these columns
        def require_cols dict 
            cols = (cols + @require_cols).to_set
            if dict.keys.to_set != cols
                raise ReindeerETL::Errors::RecordInvalid.new('Missing required columns')
            end
        end

    end
end
