module ReindeerETL::Transforms
  class Recode
    attr_accessor :cols

    def initialize opts={}
      @cols = opts[:cols]
      @except = (opts[:except] || []).to_set
      @codes = opts[:codes] || {}
      @ignore_vals = (opts[:ignore] || [])
      @ignore_all = (opts[:ignore_all] || false)
      @error_on_unknown = !@ignore_all

      if @cols.nil? && opts.keys.include?(:cols)
        raise ArgumentError.new(':cols array is empty')
      end
      @cols = @cols.to_set unless @cols.nil?
      raise ArgumentError.new(':codes hash is empty') if @codes.empty?
      @acceptable_keys = (@codes.keys + @ignore_vals).to_set
      @counter = 0
    end

    def process row
      @cols ||= row.keys.to_set - @except

      # Raise error unless all columns are present
      rset = row.keys.to_set
      unless @cols.subset?(rset)
        m_cols = @cols - rset
        raise ReindeerETL::Errors::RecordInvalid.new("Missing columns: #{m_cols.to_a}")
      end

      # Run recode
      @cols.each do |col|
        val = row[col]
        _validate_val(val)
        _update_row(row, col, val)
      end

      @counter += 1
      row
    end

    private

    def _validate_val(val)
      if @error_on_unkown && !@any_val.include?(val)
        # Raise error if we don't recognize this value
        raise ReindeerETL::Errors::RecordInvalid.new("Bad value: #{val}")
      end
    end

    def _update_row(row, col, val)
      if @acceptable_keys.include? val
        row[col] = @codes[val] if @codes.has_key?(val)
      elsif @error_on_unknown
        raise ReindeerETL::Errors::RecordInvalid.new("Invalid value in recode: row# #{@counter} {#{col}:#{val}}")
      end
    end

  end
end
