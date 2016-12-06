module Rows
  class ListRadio < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if !(val.nil? or val == "-oth-")
          ecode = "111"
        elsif val == "-oth-"
          ecode = "222"
        else
          if self_val == "-oth-" && val.nil?
            ecode = "999"
          else
            ecode = "222"
          end
        end
      end
      ecode
    end
  end
end
