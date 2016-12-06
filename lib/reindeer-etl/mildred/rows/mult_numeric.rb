module Rows
  class MultNumeric < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if val.nil?
          if relevance_condition_met?
            ecode = "999"
          else
            ecode = "777"
          end
        else
          ecode = "111"
        end
      end
      ecode
    end
  end
end
