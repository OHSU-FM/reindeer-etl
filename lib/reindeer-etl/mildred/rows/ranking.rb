module Rows
  class Ranking < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if validation.nil?
          if !val.nil?
            ecode = "333"
          else
            ecode = "222"
          end
        end
      end
      ecode
    end
  end
end
