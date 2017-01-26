module ReindeerETL::Mods
  module LotProgYr2
    module LotProgramCivilian
      extend ReindeerHelper

      def self.get row
        k = row.keys.select{ |k|
          k[h_regex, 1] == "lot_program_id"
        }.first
        ReindeerHelper::LOT_NAVY_PROGRAMS.include?(row[k]) ? "Y" : "N"
      end
    end
  end
end
