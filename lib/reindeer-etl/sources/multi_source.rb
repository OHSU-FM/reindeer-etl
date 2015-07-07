require 'set'

module ReindeerETL::Sources

    class MultiSource
        def initialize key, paths, opts={}
            @klass = opts[:klass] || ReindeerETL::Sources::CSVSource
            @key = key
            @sources = paths.map{|path|
                @klass.new path
            }
        end
        
        def each
            rows = []
            all_keys = Set.new
            @sources.each_with_index do |source, source_idx|
                first_row = false
                idx = 0
                source.each do |row|
                    unless first_row
                        first_row = true
                        all_keys += row.keys
                        unless row.keys.include? @key
                            raise ReindeerETL::Errors::RecordInvalid.new("Path#1 missing key: #{@key}")
                        end
                    end
                        
                    if source_idx == 0
                        # first source?
                        rows.push row
                    else
                        rindex = rows.index{|arow|arow[@key] == row[@key]}
                        begin
                            rows[rindex] = rows[rindex].merge(row)
                        rescue TypeError
                            raise ReindeerETL::Errors::RecordInvalid.new("Unable to Join source##{source_idx} - row##{idx}")
                        end
                    end
                    idx += 1
                end
            end
            
            rows.each do |row|
                (all_keys - row.keys).each{|k|row[k] = nil}
                yield row
            end
        end
    end

end
