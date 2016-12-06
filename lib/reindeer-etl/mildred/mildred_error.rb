module MildredError
  class DuplicateRowError < StandardError
    def initialize msg = "Multiple rows with the same question text"
      super
    end
  end

  class QuestionTypeMismatchError < StandardError
    def initialize msg = ""
      msg = "Question-type specific method called improperly: " + msg
      super
    end
  end

  class RowNotFound < StandardError
    def initialize msg=""
      super
    end
  end

  class UnknownRowError < StandardError
    def initialize msg = "type/scale not found in ROWS_DICT"
      super
    end
  end
end
