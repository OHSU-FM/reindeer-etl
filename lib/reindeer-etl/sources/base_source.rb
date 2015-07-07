require 'set'

module ReindeerETL::Sources
    class BaseSource
        include ReindeerETL::Transforms::SimpleTransforms
        
        def initialize path, opts={}
            @path = path
            st_initialize(opts)
        end
       
    end
end
