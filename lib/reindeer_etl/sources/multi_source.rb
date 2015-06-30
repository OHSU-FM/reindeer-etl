require 'set'

module ReindeerETL::Sources

    class MultiSource
        def initialize key, paths, opts={}
            @klass = opts[:klass]=> ReindeerETL::Sources::CSVSource
            @key = key
            @sources = paths.map{|path|
                @klass.new path1
            }
        end
        
        def each
            @sources.each_with_index do |source, idx|
                key_check = false
                source.each_with_index do |row, idx|
                    unless key_check
                        key_check = true
                        raise ReindeerETL::RecordInvalid.new("Path#1 missing key: #{@key}")
                    end
                        
                    if idx == 0
                        rows.push row
                    else
                        rindex = rows.index{|arow|arow[@key] == row[@key]}
                        rows[rindex].merge!(row)
                    end
                end
            end
        end
    end

end
