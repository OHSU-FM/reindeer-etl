module ReindeerETL::Mods
  module LotProgYr3
    module LotProgramYrs
      extend ReindeerHelper

      def self.get row
        k = row.keys.select{ |k|
          k[h_regex, 1] == "lot_program_id"
        }.first
        ReindeerHelper::LOT_ID_YEAR[row[k]]
      end
    end
  end
end
