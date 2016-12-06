require "csv"

module ReindeerETL::Sources
  class CSVSource < BaseSource
    def initialize path, opts = {}
      super
      @csv_opts = {headers: true, col_sep: ','}.merge(opts)
    end

    def each
      first_run = true
      CSV.foreach(@path, @csv_opts) do |row|
        if first_run
          first_run = false
          if row.headers.count != row.headers.uniq.count
            raise ReindeerETL::Errors::RecordInvalid.new('Duplicate columns')
          end
        end
        row = row.to_hash
        simple_transforms(row)
        yield(row)
      end
    end
  end
end
