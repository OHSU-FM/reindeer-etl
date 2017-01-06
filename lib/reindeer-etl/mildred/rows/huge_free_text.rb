module Rows
  class HugeFreeText < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if !mandatory.nil? && val.nil?
          ecode = "999"
        else
          ecode = "111"
        end
      end
      ecode
    end
  end
end
