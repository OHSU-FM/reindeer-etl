require "spec_helper"

describe ReindeerETL::Sources::MultiSource do
  it "must merge data from multiple sources" do
    path1 = "spec/fixtures/comma_delimited.csv"
    path2 = "spec/fixtures/comma_delimited_join_on_a.csv"
    source = ReindeerETL::Sources::MultiSource.new('a', [path1, path2])
    rows = []
    keys = %w[a b c d e f g h i j k l]
    source.each do |row|
      rows.push row
      expect(row.keys).to eq keys
    end
    expect(rows.count).to eq 13
  end

end


