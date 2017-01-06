module Rows
  class YesNo < SurveyRow
    def code val
      ecode = general_checks val
      if ecode.nil?
        if ["Y", "N"].include? val
          ecode = "111"
        else
          ecode = "999"
        end
      end
      ecode
    end
  end
end
