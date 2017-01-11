module ReindeerETL
  module Mods
    module LotGradYr2
      module LotProgramYrs
        extend ReindeerHelper

        ID_YEAR = {
          "A02" => "4yr",
          "A03" => "4yr",
          "A04" => "4yr",
          "A05" => "4yr",
          "A06" => "mixed",
          "A07" => "4yr",
          "A08" => "mixed",
          "A09" => "mixed",
          "A10" => "mixed",
          "A11" => "4yr",
          "C01" => "3yr",
          "C02" => "3yr",
          "C03" => "3yr",
          "C04" => "3yr",
          "C05" => "3yr",
          "C07" => "3yr"
        }

        def self.get row
          k = row.keys.select{ |k|
            k[h_regex, 1] == "lot_program_id"
          }.first
          ID_YEAR[row[k]]
        end
      end
    end
  end
end
