module Rows
  class LongFreeText < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if val.nil?
          if mandatory == "Y"
            ecode = "999"
          else
            ecode = "222"
          end
          if relevance.include? "NAOK"
            if relevance_condition_met?
              ecode = "999"
            else
              ecode = "777"
            end
          end
        elsif !val.nil?
          ecode = "111"
        end
      end
      ecode
    end
  end
end
