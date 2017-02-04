require 'spec_helper'

describe ReindeerETL::Sources::BaseSource do
  it "must remove columns when asked" do
    transform = ReindeerETL::Sources::BaseSource.new "", :only=>[:aa, :bb]
    row = {aa: 1, bb: 2, cc: 3}
    transform.simple_transforms row
    expect(row.keys).to eq [:aa, :bb]
  end

  it "must raise error if required fields missing" do
    transform = ReindeerETL::Sources::BaseSource.new "", :require=>[:aa]
    row = {cc: 3}
    expect{transform.simple_transforms row}.to raise_error ReindeerETL::Errors::RecordInvalid
  end

end
