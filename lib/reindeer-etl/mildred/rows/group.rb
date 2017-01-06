module Rows
  class Group < SurveyRow
    def page
      self["type/scale"].delete("^0-9").to_i + 1 # LS groups zero indexed
    end
  end
end
