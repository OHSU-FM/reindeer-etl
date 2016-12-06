require "spec_helper"

describe SurveyStructure do
  before do
    @ss = SurveyStructure.new(from_fixture)
  end

  describe "methods" do
    it "#initialize" do
      expect(@ss).to be_an_instance_of SurveyStructure
    end

    describe "#find" do
      it "gets row by index" do
        expect(@ss.find(1)).to be_an_instance_of SurveyRow
      end

      it "can accept multiple indices" do
        expect(@ss.find(1, 2)).to be_an_instance_of Array
        @ss.find(1, 2).each do |row|
          expect(row).to be_an_instance_of SurveyRow
        end
      end

      it "can accept an array of indices" do
        expect(@ss.find([1, 2])).to be_an_instance_of Array
        @ss.find([1, 2]).each do |row|
          expect(row).to be_an_instance_of SurveyRow
        end
      end
    end

    it "#find_by gets row by provided key" do
      single = @ss.find_by(name: "sid")
      expect(single).to be_an_instance_of SurveyRow
      mult = @ss.find_by(name: "sid", text: "111111")
      expect(mult).to be_an_instance_of SurveyRow
    end

    it "#meta" do
      @ss.meta.each do |row|
        expect(["S", "SL"]).to include row[:class]
      end
    end

    it "#groups" do
      @ss.groups.each do |row|
        expect(row[:class]).to eq "G"
      end
    end

    it "#questions" do
      @ss.questions.each do |row|
        expect(["Q", "SQ"]).to include row[:class]
      end
    end

    it "#only_questions" do
      @ss.only_questions.each do |row|
        expect(row[:class]).to eq "Q"
      end
    end

    it "#subquestions" do
      @ss.subquestions.each do |row|
        expect(row[:class]).to eq "SQ"
      end
    end

    it "#answers" do
      @ss.answers.each do |row|
        expect(row[:class]).to eq "A"
      end
    end
  end
end
