require "spec_helper"

describe ReindeerETL::Transforms::Recode do

  it "must recode values" do
    row = {g: :a}
    transform = ReindeerETL::Transforms::Recode.new :codes=>{:a=>:b}, :cols=>[:g]
    transform.process row
    expect(row[:g]).to eq :b
  end

  it "must raise an error if the column does not exist" do
    row = {hhh: :a}
    transform = ReindeerETL::Transforms::Recode.new codes: {a: :b}, cols: [:g]

    expect{transform.process row}.to raise_error ReindeerETL::Errors::RecordInvalid
  end

  it "must raise an error if parameters are missing" do
    expect{ReindeerETL::Transforms::Recode.new codes: {}}.to raise_error ArgumentError
    expect{ReindeerETL::Transforms::Recode.new cols: {}}.to raise_error ArgumentError
  end
end
