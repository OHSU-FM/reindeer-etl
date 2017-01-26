module ReindeerETL::Mods
  module LotClinicYr3
    module ContPracId
      def self.get row
        extend ReindeerHelper

        k = row.keys.select{|k|
          k[h_regex, 1] == "Clinic Code"
        }.first
        row[k]
      end
    end
  end
end
