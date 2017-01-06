module Rows
  class ArrayFlex < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if validation.nil? && !val.nil?
          ecode = "111"
        else
          ecode = "999"
        end
      end
      ecode
    end
  end
end
