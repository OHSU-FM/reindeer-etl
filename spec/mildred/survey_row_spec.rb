require "spec_helper"

describe SurveyRow do
  before do
    $ss = SurveyStructure.new(from_fixture)
  end

  describe "generic row" do
    before do
      @row = row_from_fixture("mildred/generic_row")
    end

    it "responds to the expected methods" do
      expect(@row.is_a_q?).not_to be_nil
      expect(@row.is_a_sq?).not_to be_nil
      expect(@row.is_a_g?).not_to be_nil
      expect(@row.is_an_a?).not_to be_nil
    end

    it "has attr readers" do
      @row.each do |key, value|
        expect(@row.send(key.to_sym)).to eq value
      end
    end

    it "can reference the global survey stucture" do
      expect(@row.survey_structure).to eq $ss
    end
  end

  describe "question row" do
    before do
      @row = row_from_fixture("mildred/question_row")
    end

    it "#is_a_q?" do
      expect(@row.is_a_q?).to be_truthy
    end

    it "!#is_a_sq?" do
      expect(@row.is_a_sq?).to be_falsey
    end

    it "!#is_a_g?" do
      expect(@row.is_a_g?).to be_falsey
    end

    it "!#is_an_a?" do
      expect(@row.is_an_a?).to be_falsey
    end

    it "#has_children?" do
      expect(@row.has_children?).to be_truthy
    end

    it "#children" do
      @sq = row_from_fixture("mildred/subquestion_row")
      expect(@row.children.count).to eq 7
      expect(@row.children).to include @sq
    end

    it "#group" do
      @g = row_from_fixture("mildred/group_row")
      expect(@row.group).to eq @g
    end

    it "#parent" do
      expect{@row.parent}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#subquestions" do
      @sq = row_from_fixture("mildred/subquestion_row")
      expect(@row.subquestions.length).to eq 1
      expect(@row.subquestions).to include @sq
    end

    it "#answers" do
      @ans = row_from_fixture("mildred/answer_row")
      expect(@row.answers.length).to eq 6
      expect(@row.answers).to include @ans
    end
  end

  describe "subquestion row" do
    before do
      @row = row_from_fixture("mildred/subquestion_row")
    end

    it "!#is_a_q?" do
      expect(@row.is_a_q?).not_to be_truthy
    end

    it "#is_a_sq?" do
      expect(@row.is_a_sq?).to be_truthy
    end

    it "#is_a_g?" do
      expect(@row.is_a_g?).to be_falsey
    end

    it "#has_children?" do
      expect{@row.has_children?}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#children" do
      expect{@row.children}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#group" do
      @g = row_from_fixture("mildred/group_row")
      expect(@row.group).to eq @g
    end

    it "#parent" do
      @q = row_from_fixture("mildred/question_row")
      expect(@row.parent).to eq @q
    end

    it "#subquestions" do
      expect{@row.subquestions}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#answers" do
      expect{@row.answers}.to raise_error MildredError::QuestionTypeMismatchError
    end
  end

  describe "answer row" do
    before do
      @row = row_from_fixture("mildred/answer_row")
    end

    it "!#is_a_q?" do
      expect(@row.is_a_q?).to be_falsey
    end

    it "!#is_a_sq?" do
      expect(@row.is_a_sq?).to be_falsey
    end

    it "#is_an_a?" do
      expect(@row.is_an_a?).to be_truthy
    end

    it "#is_a_g?" do
      expect(@row.is_a_g?).to be_falsey
    end

    it "#has_children?" do
      expect{@row.has_children?}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#children" do
      expect{@row.children}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#group" do
      @g = row_from_fixture("mildred/group_row")
      expect(@row.group).to eq @g
    end

    it "#parent" do
      @q = row_from_fixture("mildred/question_row")
      expect(@row.parent).to eq @q
    end

    it "#subquestions" do
      expect{@row.subquestions}.to raise_error MildredError::QuestionTypeMismatchError
    end

    it "#answers" do
      expect{@row.answers}.to raise_error MildredError::QuestionTypeMismatchError
    end
  end
end
