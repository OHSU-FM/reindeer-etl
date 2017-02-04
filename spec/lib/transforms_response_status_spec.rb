require "spec_helper"

describe ReindeerETL::Transforms::RenameFields do
  before do
    cols = {:aaa=>:bbb, :ccc=>:ddd}
    @transform = ReindeerETL::Transforms::RenameFields.new cols
  end

  it "must raise an error when the column is not in the row" do
    row = {}
    expect{ @transform.process row }.to raise_error ReindeerETL::Errors::RecordInvalid
  end

  it "must rename fields" do
    row = {:aaa=>555, :ccc=>888}
    row = @transform.process row
    expect(row.keys.include?(:aaa)).to be_falsey
    expect(row.keys.include?(:bbb)).to be_truthy
  end

end

