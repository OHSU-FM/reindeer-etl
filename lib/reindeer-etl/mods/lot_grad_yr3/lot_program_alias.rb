module ReindeerETL::Mods
  module LotGradYr3
    module LotProgramAlias
      extend ReindeerHelper

      def self.get row
        k = row.keys.select{ |k|
          k[h_regex, 1] == "lot_program_id"
        }.first
        binding.pry if k == "A08"
        ReindeerHelper::LOT_ID_ALIAS[row[k]]
      end
    end
  end
end
