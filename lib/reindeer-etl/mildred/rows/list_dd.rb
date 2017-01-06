module Rows
  class ListDropdown < SurveyRow
    def code val, sq=nil
      ecode = general_checks val
      if ecode.nil?
        if answers.map{|a| a.text }.include? val
          ecode = "111"
        elsif answers.map {|a| a.name }.include? val
          ecode = "111"
        elsif !self_val.nil? && sq && sq["name"] == "other"
          ecode = "777" # dd w other option
        elsif val == "-oth-"
          ecode = "111"
        else
          ecode = "999"
        end
      end
      ecode
    end
  end
end
