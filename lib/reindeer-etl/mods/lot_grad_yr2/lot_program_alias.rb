module ReindeerETL
  module Mods
    module LotGradYr2
      module LotProgramAlias
        extend ReindeerHelper

        ID_ALIAS = {
          "A02" => "6",
          "A03" => "7",
          "A04" => "1",
          "A05" => "10",
          "A06" => "5",
          "A07" => "11",
          "A08" => "2",
          "A09" => "12",
          "A10" => "13",
          "A11" => "14",
          "C01" => "8",
          "C02" => "9",
          "C03" => "15",
          "C04" => "16",
          "C05" => "17",
          "C07" => "3"
        }

        def self.get row
          k = row.keys.select{ |k|
            k[h_regex, 1] == "lot_program_id"
          }.first
          binding.pry if k == "A08"
          ID_ALIAS[row[k]]
        end
      end
    end
  end
end
