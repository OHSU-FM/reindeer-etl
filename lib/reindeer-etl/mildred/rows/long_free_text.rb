module Rows
  class LongFreeText < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if mandatory.nil?
          ecode = val.nil? ? "222" : "333"
        else
          ecode = val.nil? ? "999" : "111"
        end
      end
      ecode
    end
  end
end
