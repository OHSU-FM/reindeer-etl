require "spec_helper"

def loads_as_hash path, opts={}
  source = ReindeerETL::Sources::CSVSource.new(path, opts)
  counter = 0
  source.each do |row|
    expect(row.keys).to eq %w{a b c d e f g h i}
    counter += 1
    expect(counter).to eq row['a'].to_i
  end
  expect(counter).to eq 13
end

describe ReindeerETL::Sources::CSVSource do
  it 'must yield each line of a csv file as a hash' do
    path = "spec/fixtures/comma_delimited.csv"
    loads_as_hash(path, :col_sep=>',')
  end

  it 'must yield each line of a tabbed csv file as a hash' do
    path = "spec/fixtures/tab_delimited.csv"
    loads_as_hash(path, :col_sep=>"\t")
  end
end
