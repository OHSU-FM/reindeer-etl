module Rows
  class Subquestion < SurveyRow
    def code val
      ecode = general_checks val
      if ecode.nil?
        ecode = parent.code(val, self)
      end
      ecode
    end
  end
end
