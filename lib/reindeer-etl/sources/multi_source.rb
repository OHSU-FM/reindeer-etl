require 'set'

module ReindeerETL::Sources
  class MultiSource
    def initialize key, paths, opts={}
      @klass = opts[:klass] || ReindeerETL::Sources::CSVSource
      @key = key
      @klass_opts = opts[:klass_opts] || Array.new(paths.length, {})
      @sources = paths.zip(@klass_opts).map{|path, opts|
        @klass.new path, opts
      }
      @expect_full_match = opts[:expect_full_match] || false
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
            if rindex.nil? && @expect_full_match
              raise ReindeerETL::Errors::RecordInvalid.new("Unable to Join source##{source_idx} - row##{idx}")
            else
              if rindex.nil?
                next
              else
                begin
                  rows[rindex] = rows[rindex].merge(row)
                rescue TypeError
                  raise ReindeerETL::Errors::RecordInvalid.new("Unable to Join source##{source_idx} - row##{idx}")
                end
              end
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
