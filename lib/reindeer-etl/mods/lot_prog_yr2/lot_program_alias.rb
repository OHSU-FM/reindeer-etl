module ReindeerETL::Mods
  module LotProgYr2
    module LotProgramAlias
      extend ReindeerHelper

      def self.get row
        k = row.keys.select{ |k|
          k[h_regex, 1] == "lot_program_id"
        }.first
        ReindeerHelper::LOT_ID_ALIAS[row[k]]
      end
    end
  end
end
