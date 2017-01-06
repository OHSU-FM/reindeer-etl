module Rows
  class Boilerplate < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        ecode = "111"
      end
      ecode
    end
  end
end
