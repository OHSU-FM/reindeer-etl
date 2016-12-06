module Rows
  class ListDropdown < SurveyRow
    def code val
      ecode = general_checks val
      if ecode.nil?
        if answers.map{|a| a.text }.include? val
          ecode = "111"
        else
          ecode = "999"
        end
      end
      ecode
    end
  end
end
