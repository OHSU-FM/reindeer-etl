module ReindeerETL
    class BaseSource
        def initialize path, opts={}
           @only_cols = opts.delete[:only] || []
        end

        def strip_cols dict
            (dict.keys -  @only_cols).each{|col|dict.delete(col)}
        end

        def require_cols dict, opts={}
            cols = opts[:cols] || []
            cols = (cols + @only_cols).uniq
            
        end

    end
end
