class SurveyRow < OpenStruct

  CODES = {
    "111" => "Answered",
    "222" => "Optional - Unanswered",
    "333" => "Optional - Answered",
    "555" => "Invalid Response",
    "777" => "Skipped/Not Asked",
    "888" => "Not Applicable",
    "999" => "Missing"
  }

  def survey_structure
    $ss
  end

  def is_a_q?
    self[:class] == "Q"
  end

  def is_a_sq?
    self[:class] == "SQ"
  end

  def is_a_g?
    self[:class] == "G"
  end

  def is_an_a?
    self[:class] == "A"
  end

  def has_children?
    children.count > 0
  end

  # returns list of subquestions and answers
  def children
    unless is_a_q?
      raise MildredError::QuestionTypeMismatchError.new("q on sq, a, or g")
    end

    children = []
    survey_structure.next_row_is_child? self, children
  end

  def parent
    unless is_a_sq? or is_an_a?
      raise MildredError::QuestionTypeMismatchError.new("sq on q or g")
    end

    survey_structure.prev_row_is_q? self
  end

  def subquestions
    unless is_a_q?
      raise MildredError::QuestionTypeMismatchError.new("q on sq, a, or g")
    end

    children.select{|r| r["class"] == "SQ"}
  end

  def answers
    unless is_a_q?
      raise MildredError::QuestionTypeMismatchError.new("q on sq, a or g")
    end

    children.select{|r| r["class"] == "A"}
  end

  # catches coding cases that apply to all row subclasses
  def general_checks val
    self["self_val"] = val if self_val.nil?

    if val.nil?
      if mandatory == "Y"
        if !relevance.include? "NAOK" # skip logic
          @check_skip = false
        else
          @check_skip = true
        end
      end
    elsif val == "{question_not_shown}"
      ecode = "777"
    end
    ecode
  end

  def relevance_condition_met?
    t=relevance[/\(\((.*?)\)\)/m, 1]
    q = t.split(".")[0]
    tar = t[/\"(.*?)\"/m, 1]
    survey_structure.find_by_name(q, nil).self_val == tar ? true : false
  end
end
