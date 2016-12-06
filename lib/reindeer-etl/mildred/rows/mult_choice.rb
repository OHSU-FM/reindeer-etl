module Rows
  class MultChoice < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if val.nil?
          ecode = "222"
        else
          ecode = "333"
        end
      end
      ecode
    end
  end
end
