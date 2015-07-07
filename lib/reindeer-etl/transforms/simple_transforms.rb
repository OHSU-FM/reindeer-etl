module ReindeerETL::Transforms
    module SimpleTransforms
        def st_initialize opts={}
            @only_cols = (opts.delete(:only) || []).to_set
            @require_cols = (opts.delete(:require) || []).to_set
        end
       
        ## 
        # Configurable transforms in source
        def simple_transforms row
            st_only_cols(row) unless @only_cols.empty?
            st_require_cols(row) unless @require_cols.empty?
            row
        end
        
        ##
        # Filter out everything except these columns
        def st_only_cols dict
            (dict.keys.to_set - @only_cols).each{|col|dict.delete(col)}
            dict
        end
        
        ## 
        # require these columns
        def st_require_cols dict
            dcols = dict.keys.to_set
            unless @require_cols.subset? dict.keys.to_set
                missing_cols = (@require_cols - dcols).to_a
                raise ReindeerETL::Errors::RecordInvalid.new("Missing required columns: #{missing_cols}")
            end
        end
    end
end
