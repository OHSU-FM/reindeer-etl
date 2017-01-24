require 'progress_bar'

module ReindeerETL::Transforms
  class ResponseStatus
    # designator for reindeer stats cols
    REP_COL_PREFIX = "responseStatus_"

    # @param complete [Boolean] optional flag to skip incomplete response check
    def initialize path, opts={}
      @path = path
      @except_cols = (opts[:except] || []).to_set
      @complete = opts[:complete]
      @bar = ProgressBar.new($length)
    end

    def process row
      @bar.increment!
      # get a fresh survey_structure from Mildred for each row
      $ss = SurveyStructure.new(@path, row["lastpage"].to_i, @complete)

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
          if ($ss.lastpage < $ss.find_by_name(k.split("_")[0], nil).group.page) and
              !$ss.complete
            ecode = "999"
          else
            ecode = $ss.code_array(val)
          end
        else
          q = $ss.find_by_name(k, val)
          if !q.respond_to? :code
            ReindeerETL::Errors::RecordInvalid.new("SurveyStructure row '#{k}' does not respond to #code. Add as except_col?")
          end
          ecode = q.code(val)
        end
        row[new_col] = "E#{ecode}E"
      end
      row
    end
  end
end
