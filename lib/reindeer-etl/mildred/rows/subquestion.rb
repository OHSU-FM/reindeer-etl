module Rows
  class Subquestion < SurveyRow
    def code val
      ecode = general_checks val
      if ecode.nil?
        if !(val.nil? || parent.self_val.nil?) && name == "other"
          ecode = "111"
        elsif
          ecode = parent.code(val, self)
        end
      end
      ecode
    end
  end
end
