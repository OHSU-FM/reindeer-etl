module Rows
  class Gender < SurveyRow
    def code val
      ecode = general_checks val
      if ecode.nil?
        if ["M", "F"].include? val
          ecode = "111"
        else
          ecode = "999"
        end
      end
      ecode
    end
  end
end
