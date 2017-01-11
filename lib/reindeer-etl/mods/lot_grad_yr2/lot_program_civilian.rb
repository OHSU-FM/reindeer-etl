module ReindeerETL
  module Mods
    module LotGradYr2
      module LotProgramCivilian
        extend ReindeerHelper

        NAVY_PROGRAMS = ["A06", "A08", "A09", "A10"]

        def self.get row
          k = row.keys.select{ |k|
            k[h_regex, 1] == "lot_program_id"
          }.first
          NAVY_PROGRAMS.include?(row[k]) ? "Y" : "N"
        end
      end
    end
  end
end
