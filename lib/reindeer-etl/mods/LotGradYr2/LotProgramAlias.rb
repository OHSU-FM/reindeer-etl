module ReindeerETL
  module Mods
    module LotGradYr2
      module LotProgramAlias
        extend ReindeerHelper

        def self.get row
          k = row.keys.select{ |k|
            k[h_regex, 1] == "lot_program_id"
          }.first
          # TODO put that into a hash that gives the right alias
        end
      end
    end
  end
end
