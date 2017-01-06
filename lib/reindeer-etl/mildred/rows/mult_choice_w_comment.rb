module Rows
  class MultChoiceWComment < SurveyRow
    def code val, sq=nil
      # limesurvey validates that every checked choice also has a comment, so we
      # won't(/can't?) repeat that check
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
