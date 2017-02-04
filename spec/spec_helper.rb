require "rspec"
require "yaml"
require "pry"

require_relative "../lib/reindeer-etl"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
    c.syntax = :expect
  end
end

def from_fixture
  "./spec/fixtures/mildred/limesurvey_survey.csv"
end

def row_from_fixture fixture_path
  case YAML.load_file("spec/fixtures/#{fixture_path}.yaml")["type/scale"]
  when "K"
    survey_row = Rows::MultNumeric.new
  when "F"
    survey_row = Rows::ArrayFlex.new
  else
    survey_row = SurveyRow.new
  end

  YAML.load_file("spec/fixtures/#{fixture_path}.yaml").map {|k, v| survey_row[k] = v }
  survey_row
end
