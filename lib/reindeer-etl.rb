module ReindeerETL
  # Your code goes here...

  module Sources
  end

  module Transforms
  end

  module Destinations
  end

end

require 'rest-client'
require 'pp'

require 'reindeer-etl/version'
require 'reindeer-etl/errors'

require 'reindeer-etl/transforms/simple_transforms'
require 'reindeer-etl/transforms/recode'
require 'reindeer-etl/transforms/rename_fields'
require 'reindeer-etl/transforms/response_status'

require 'reindeer-etl/sources/base_source'
require 'reindeer-etl/sources/csv_source'
require 'reindeer-etl/sources/multi_source'

require 'reindeer-etl/destinations/csv_dest'
require 'reindeer-etl/destinations/lime_survey_curl'
