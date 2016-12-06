module Rows
  class Gender < SurveyRow
    def code val
      ecode = general_checks val
      if ecode.nil?
        if relevance_condition_met?
          if ["M", "F"].include? val
            ecode = "111"
          else
            ecode = "999"
          end
        else
          ecode = "777"
        end
      end
      ecode
    end
  end
end
