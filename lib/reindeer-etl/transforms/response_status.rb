module ReindeerETL::Transforms
  class ResponseStatus
    # designatorr reindeer stats cols
    REP_COL_PREFIX = "responseStatus_"

    def initialize path, opts={}
      @path = path
      @except_cols = (opts[:except] || []).to_set
    end

    def process(row)
      # get a fresh survey_structure from Mildred for each row
      $ss = SurveyStructure.new(@path)

      row = row.reject{|e| e.nil? } # nil values screw things up
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

        # ham-handed way of getting rid of bad commas in response
        unless val.nil?
          if val.include? ","
            row[k] = val.gsub(",", ";")
          end
        end

        if k.split("_").length == 3
          ecode = $ss.code_array(k, val)
        else
          ecode = $ss.find_by_name(k, val).code(val)
        end
        row[new_col] = "E#{ecode}E"
      end
      row
    end
  end
end
